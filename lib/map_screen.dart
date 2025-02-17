import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'event_details_screen.dart';

class MapScreen extends StatefulWidget {
  final List<Map<String, dynamic>> events;

  MapScreen({required this.events});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();

  void animatedMove(LatLng destLocation, double destZoom) {
    final _latTween = Tween<double>(
      begin: _mapController.camera.center.latitude,
      end: destLocation.latitude,
    );
    final _lngTween = Tween<double>(
      begin: _mapController.camera.center.longitude,
      end: destLocation.longitude,
    );
    final _zoomTween = Tween<double>(
      begin: _mapController.camera.zoom,
      end: destZoom,
    );

    final animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: Navigator.of(context),
    );

    animationController.addListener(() {
      _mapController.move(
        LatLng(_latTween.evaluate(animationController), _lngTween.evaluate(animationController)),
        _zoomTween.evaluate(animationController),
      );
    });

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Map'),
        backgroundColor: Color.fromARGB(255, 98, 117, 255),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: LatLng(42.7087, 19.3744),
          initialZoom: 9.0,
          interactionOptions: InteractionOptions(
            flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
          ),
        ),
        children: [
  
TileLayer(
   urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
   subdomains: ['a', 'b', 'c'],
   userAgentPackageName: 'com.example.app',
),


          MarkerLayer(
            markers: widget.events.map((event) {
              final imagePath = 'assets/images/${event['category']}.png';
              return Marker(
                width: 60.0,
                height: 80.0,
                point: LatLng(event['latitude'], event['longitude']),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => EventDetailsScreen(
                        title: event['title'],
                        date: event['date'],
                        location: event['location'],
                        description: event['description'],
                        imagePath: event['imagePath'],
                        themeColor: event['themeColor'],
                      ),
                    ));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Flexible(
                        child: Container(
                          width: 60,
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            event['title'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.blueAccent,
                    onPressed: () {
                      animatedMove(_mapController.camera.center, _mapController.camera.zoom + 1);
                    },
                    child: Icon(Icons.add, size: 20),
                  ),
                  SizedBox(height: 8),
                  FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.redAccent,
                    onPressed: () {
                      animatedMove(_mapController.camera.center, _mapController.camera.zoom - 1);
                    },
                    child: Icon(Icons.remove, size: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
