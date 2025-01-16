import 'package:flutter/material.dart';
import 'map_screen.dart';
import 'event_details_screen.dart';

class HomeScreen extends StatefulWidget {
  final String selectedCategory;

  const HomeScreen({Key? key, required this.selectedCategory}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _selectedCategory = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Ključ za kontrolu Drawer-a

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
    'themeColor':  const Color.fromARGB(255, 53, 125, 203),
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
  },
  {
    'title': 'Filmski Festival U Tivtu',
    'date': '5. avgust, 2025',
    'location': 'Tivat',
    'category': 'Film',
    'imagePath': 'assets/images/film.jpg',
    'description':
        'Pozivamo vas na nezaboravne filmske projekcije na otvorenom uz more, uz prisustvo renomiranih filmskih umjetnika.',
    'themeColor': const Color(0xFFFF6F61),
  },
];


  @override
  void initState() {
    super.initState();
    _selectedCategory =
        widget.selectedCategory.isEmpty ? '' : widget.selectedCategory; // Ako nema kategorije, setuj kao prazan string
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
        builder: (context) => MapScreen(),
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

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lokacija: Crna Gora',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            SizedBox(height: 4),
            TextField(
              decoration: InputDecoration(
                hintText: 'Pretraži događaje',
                hintStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: const Color.fromARGB(255, 126, 141, 255),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 98, 117, 255),
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
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(''), 
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
                        'ashfak@email.com', 
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
              title: Text('My Profile'),
              onTap: () {
                Navigator.pop(context); 
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text('Bookmark'),
              onTap: () {
                Navigator.pop(context); 
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.pop(context); 
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Helps & FAQs'),
              onTap: () {
                Navigator.pop(context); 
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sign Out'),
              onTap: () {
                Navigator.pop(context); 
              },
            ),
          ],
        ),
      ),
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
                    bool isSelected = _selectedCategory == category['label'];
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
                        style:
                            TextStyle(fontSize: 18, color: Colors.grey),
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
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
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
                      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
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
      ),
    );
  }
}
