import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  final String email;
  final String password;
  final String username;

  UserProfilePage({required this.email, required this.password, required this.username});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late String username;

  @override
  void initState() {
    super.initState();
    username = widget.username;
  }

  void _updateUsername(String newName) {
    setState(() {
      username = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Moj Profil'),
        backgroundColor: Colors.blue[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_placeholder.png'), // Ubaci sliku ovde
              backgroundColor: Colors.blue[100],
            ),
            SizedBox(height: 20),
            Text(
              'Email: ${widget.email}',
              style: TextStyle(fontSize: 16, color: Colors.blue[900]),
            ),
            SizedBox(height: 10),
            Text(
              'Šifra: ${widget.password}',
              style: TextStyle(fontSize: 16, color: Colors.blue[900]),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ime: $username',
                  style: TextStyle(fontSize: 16, color: Colors.blue[900]),
                ),
                TextButton(
                  onPressed: () async {
                    final newName = await showDialog<String>(
                      context: context,
                      builder: (context) {
                        String tempName = username;
                        return AlertDialog(
                          title: Text('Izmijeni ime'),
                          content: TextField(
                            onChanged: (value) {
                              tempName = value;
                            },
                            decoration: InputDecoration(hintText: 'Unesite novo ime'),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, null);
                              },
                              child: Text('Odustani'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, tempName);
                              },
                              child: Text('Sačuvaj'),
                            ),
                          ],
                        );
                      },
                    );

                    if (newName != null && newName.isNotEmpty) {
                      _updateUsername(newName);
                    }
                  },
                  child: Text('Izmijeni'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
