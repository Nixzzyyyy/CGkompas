import 'package:flutter/material.dart';

class SavedEventsPage extends StatefulWidget {
  static List<Map<String, String>> savedEvents = [];

  @override
  _SavedEventsPageState createState() => _SavedEventsPageState();
}

class _SavedEventsPageState extends State<SavedEventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sačuvani Događaji'),
      ),
      body: SavedEventsPage.savedEvents.isEmpty
          ? Center(child: Text('Nema sačuvanih događaja.'))
          : ListView.builder(
              itemCount: SavedEventsPage.savedEvents.length,
              itemBuilder: (context, index) {
                final event = SavedEventsPage.savedEvents[index];
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    setState(() {
                      SavedEventsPage.savedEvents.removeAt(index);
                    });
                  },
                  background: Container(color: Colors.red),
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      leading: Image.asset(
                        event['imagePath']!,
                        fit: BoxFit.cover,
                        width: 50,
                      ),
                      title: Text(
                        event['title']!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('${event['date']} - ${event['location']}'),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
