import 'package:event/profile.dart';
import 'package:flutter/material.dart';
import 'map_screen.dart';
import 'dart:ui';
import 'event_details_screen.dart';
import 'login.dart';
import 'about.dart';
import 'package:confetti/confetti.dart';
import 'savedEvents.dart';

class HomeScreen extends StatefulWidget {
  final String selectedCategory;

  const HomeScreen({Key? key, required this.selectedCategory}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _selectedCategory = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> _categories = [
    {'label': 'Umjetnost', 'color': const Color(0xFFFF6F91)},
    {'label': 'Muzika', 'color': const Color(0xFFFFA07A)},
    {'label': 'Tradicija', 'color': const Color(0xFF57C6E1)},
    {'label': 'Ekologija', 'color': const Color(0xFF81D742)},
    {'label': 'Priroda', 'color': const Color(0xFFC084FC)},
    {'label': 'Festival', 'color': const Color.fromARGB(255, 53, 125, 203)},
    {'label': 'Film', 'color': const Color(0xFFFF6F61)},
    {'label': 'Hrana', 'color': const Color.fromARGB(255, 172, 255, 100)},
  ];

  final List<Map<String, dynamic>> _events = [
    {
      'title': 'Praznik Mimoze',
      'date': '1. februar, 2025',
      'location': 'Herceg Novi',
      'category': 'Festival',
      'imagePath': 'assets/images/mimoza.png',
      'description':
          'Proslavite početak proljeća uz jedinstveni festival posvećen mimozi, sa paradama, koncertima i umjetničkim događajima.',
      'themeColor': const Color.fromARGB(255, 53, 125, 203),
      'latitude': 42.456121,
      'longitude': 18.531664,
    },
    {
      'title': 'Bokeljska Noć',
      'date': '15. avgust, 2025',
      'location': 'Kotor',
      'category': 'Tradicija',
      'imagePath': 'assets/images/bokeljska.jpg',
      'description':
          'Jedinstvena noć proslave u starom gradu Kotoru uz osvetljene barke, muziku i vatromet.',
      'themeColor': const Color(0xFF57C6E1),
      'latitude': 42.425337,
      'longitude': 18.770962,
    },
    {
      'title': 'Bedem Fest',
      'date': '20. jul, 2025',
      'location': 'Nikšić',
      'category': 'Muzika',
      'imagePath': 'assets/images/bedem.jpg',
      'description':
          'Uživajte u energiji Bedem Festa sa nastupima najboljih domaćih i regionalnih bendova na istorijskom bedemu.',
      'themeColor': const Color(0xFFFFA07A),
      'latitude': 42.783746,
      'longitude': 18.949323,
    },
    {
      'title': 'Filmski Festival U Tivtu',
      'date': '5. avgust, 2025',
      'location': 'Tivat',
      'category': 'Film',
      'imagePath': 'assets/images/filmic.jpg',
      'description':
          'Pozivamo vas na nezaboravne filmske projekcije na otvorenom uz more, uz prisustvo renomiranih filmskih umjetnika.',
      'themeColor': const Color(0xFFFF6F61),
      'latitude': 42.432357,
      'longitude': 18.702109,
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory =
        widget.selectedCategory.isEmpty ? '' : widget.selectedCategory;
  }

  void _onCategorySelect(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _deselectCategory() {
    setState(() {
      _selectedCategory = '';
    });
  }

  void _onBottomNavTap(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapScreen(events: _events),
        ),
      ).then((_) {
        setState(() {
          _selectedIndex = 0;
        });
      });
    } else if (index == 2) {
      _scaffoldKey.currentState?.openDrawer();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredEvents = _selectedCategory.isEmpty
        ? _events
        : _events
            .where((event) => event['category'] == _selectedCategory)
            .toList();

    return Stack(
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
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          ),

        Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 60,
                    width: 60,
                  ),
                ),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Pretraži događaje',
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      filled: true,
                      fillColor: const Color(0xFF8BADE6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            backgroundColor: const Color.fromARGB(255, 164, 195, 243),
            toolbarHeight: 90,
          ),
          drawer: Drawer(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      DrawerHeader(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 126, 141, 255),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/user.jpg'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ashfak Sayem',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'abc@email.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      ListTile(
        leading: Icon(Icons.person),
        title: Text('Moj profil'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserProfilePage(
                email: "abc@gmail.com", 
                password: "123", 
                username: "nik",
                ),
                ),
            );
        },
      ),
      ListTile(
        leading: Icon(Icons.bookmark),
        title: Text('Događaji'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SavedEventsPage(),
              ),
            );
        },
      ),
     ListTile(
  leading: Icon(Icons.contact_mail),
  title: Text('Kontaktirajte nas'),
  onTap: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Kontakt informacije',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.person, color: Colors.blue),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nikolina Pejović",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Dizajner i frontend developer"),
                        Text(
                          "pejovic.nikolina2@gmail.com",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.person, color: Colors.blue),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Vladislav Serkizyuk",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Backend developer"),
                        Text(
                          "gmail",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Slobodno nam se obratite!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Zatvori"),
            ),
          ],
        );
      },
    );
  },
),
      ListTile(
        leading: Icon(Icons.info),
        title: Text('O nama'),
        onTap: () {
          showAboutUsDialog(context);
        },
      ),
       ListTile(
  leading: Icon(Icons.logout),
  title: Text('Sign Out'),
  onTap: () {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), 
        ),
        backgroundColor: Colors.white, 
        title: Text(
          "Potvrda",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6C63FF), 
          ),
        ),
        content: Text(
          "Da li ste sigurni da želite da se odjavite?",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87, 
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: Text(
              "Otkaži",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey, 
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); 
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()), 
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6C63FF), 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), 
              ),
            ),
            child: Text(
              "Da",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white, 
              ),
            ),
          ),
        ],
      ),
    );
  },
)


    ],
  ),
),

          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ElevatedButton(
                        onPressed: _deselectCategory,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text('Svi Događaji'),
                      ),
                      SizedBox(width: 8),
                      ..._categories.map((category) {
                        bool isSelected =
                            _selectedCategory == category['label'];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ElevatedButton(
                            onPressed: () =>
                                _onCategorySelect(category['label']),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isSelected
                                  ? category['color']
                                  : Colors.grey.shade300,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              category['label'],
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Predstojeći Događaji',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: filteredEvents.isEmpty
                      ? Center(
                          child: Text(
                            'Trenutno nema događaja pod tim #',
                            style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredEvents.length,
                          itemBuilder: (context, index) {
                            final event = filteredEvents[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: EventCard(
                                title: event['title'],
                                date: event['date'],
                                location: event['location'],
                                themeColor: event['themeColor'],
                                imagePath: event['imagePath'],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EventDetailsScreen(
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
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color.fromARGB(255, 98, 117, 255),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            currentIndex: _selectedIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Istražite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Mapa',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Podešavanja',
              ),
            ],
            onTap: _onBottomNavTap,
          ),
        ),
      ],
    );
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String location;
  final Color themeColor;
  final String imagePath;
  final VoidCallback onTap;

  EventCard({
    required this.title,
    required this.date,
    required this.location,
    required this.themeColor,
    required this.imagePath,
    required this.onTap,
  });

  @override
Widget build(BuildContext context) {
  final ConfettiController _confettiController =
      ConfettiController(duration: Duration(seconds: 1)); 

  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    height: 160,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '$date - $location',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: onTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                        ),
                        child: Text(
                          'Detalji',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 10,
              right: 10,
              child: StatefulBuilder(
                builder: (context, setState) {
                  bool isBookmarked = SavedEventsPage.savedEvents.any(
                    (event) =>
                        event['title'] == title &&
                        event['date'] == date &&
                        event['location'] == location,
                  );

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          isBookmarked
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: isBookmarked ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            if (!isBookmarked) {
                              SavedEventsPage.savedEvents.add({
                                'imagePath': imagePath,
                                'title': title,
                                'date': date,
                                'location': location,
                              });
                              _confettiController.play(); 
                            } else {
                              SavedEventsPage.savedEvents.removeWhere((event) =>
                                  event['title'] == title &&
                                  event['date'] == date &&
                                  event['location'] == location);
                            }
                          });
                        },
                      ),
                      ConfettiWidget(
                        confettiController: _confettiController,
                        blastDirectionality: BlastDirectionality.explosive,
                        shouldLoop: false,
                        colors: [
                          Colors.red,
                          Colors.blue,
                          Colors.green,
                          Colors.yellow
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}