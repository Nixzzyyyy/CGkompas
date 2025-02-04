import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'event_details_screen.dart';

class MapScreen extends StatelessWidget {
  final List<Map<String, dynamic>> events;

  MapScreen({required this.events});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Map'),
        backgroundColor: const Color.fromARGB(255, 98, 117, 255),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(42.765543, 19.251345),
          initialZoom: 8.5,
        ),
        children: [
          TileLayer(
            urlTemplate:
            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
              markers: events.map((event) {
                final imagePath = 'assets/images/${event['category']}.png';
                return Marker(
                  width: 50.0,
                  height: 90.0,
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
                                    ),
                      );
                    },

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: ClipRRect(
                            child: Image.asset(
                              imagePath,
                              width: 30.0,
                              height: 30.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),  // image x title spacing
                        Text(
                          event['title'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
          ),
        ],
      ),
    );
  }
}


