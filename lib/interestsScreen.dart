import 'package:flutter/material.dart';
import 'package:event/HomeScreen.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  _InterestsScreenState createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final List<String> interests = [
    "Umetnost",
    "Muzika",
    "Tradicija",
    "Ekologija",
    "Priroda",
    "Festival",
    "Film",
    "Hrana",
  ];

  final List<Color> interestColors = [
    const Color(0xFFFF6F91),
    const Color(0xFFFFA07A),
    const Color(0xFF57C6E1),
    const Color(0xFF81D742),
    const Color(0xFFC084FC),
    const Color.fromARGB(255, 53, 125, 203),
    const Color(0xFFFF6F61),
    const Color.fromARGB(255, 172, 255, 100),
  ];

  String? selectedInterest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFf4f4f8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              "Interesovanja",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 20,
                  childAspectRatio: 2,
                ),
                itemCount: interests.length,
                itemBuilder: (context, index) {
  final interest = interests[index];
  final isSelected = selectedInterest == interest;
  return GestureDetector(
    onTap: () {
      setState(() {
        selectedInterest = interest;
      });
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Colors.black : Colors.transparent,
          width: 2,
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/${interest.toLowerCase()}.jpg'), 
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(isSelected ? 0.5 : 0.7), 
            BlendMode.srcATop,
          ),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        interest,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white, 
          shadows: [
            Shadow(
              offset: Offset(1, 1),
              blurRadius: 3,
              color: Colors.black54, 
            ),
          ],
        ),
      ),
    ),
  );
},
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF6C63FF),
              child: Column(
                children: [
                  const Text(
                    "Izaberite interesovanja kako bismo vam pružili najbolje iskustvo.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedInterest != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HomeScreen(selectedCategory: selectedInterest!),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Molimo izaberite kategoriju."),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6C63FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      "Završite",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
