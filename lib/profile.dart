import 'package:flutter/material.dart';
import 'dart:ui';

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
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 98, 117, 255),
        title: Row(
          children: [
            Icon(Icons.person, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Moj Profil',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.4),
                  BlendMode.lighten,
                ),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/user.jpg'),
                      backgroundColor: Colors.blue[100],
                    ),
                    SizedBox(height: 20),
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.email,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    Divider(height: 30, thickness: 1.5, color: Colors.blue[200]),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildProfileRow('Email', widget.email),
                          SizedBox(height: 10),
                          _buildProfileRow('Šifra', widget.password),
                          SizedBox(height: 10),
                          _buildEditableRow('Ime', username, onEdit: () async {
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
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blue[900]),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16, color: Colors.grey[800]),
        ),
      ],
    );
  }

  Widget _buildEditableRow(String title, String value, {required VoidCallback onEdit}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blue[900]),
        ),
        Row(
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            SizedBox(width: 10),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue[600]),
              onPressed: onEdit,
            ),
          ],
        ),
      ],
    );
  }
}
