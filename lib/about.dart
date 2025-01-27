import 'package:flutter/material.dart';

void showAboutUsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'O nama - CG Kompas',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dobrodošli u CG Kompas!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'Zamislite kako uživate u večeri uz obalu mora, istražujući autentične lokalne štandove s domaćim proizvodima ili otkrivate najzanimljivije festivale i kulturne događaje. Uz CG Kompas, sve to je moguće, jednostavno i lako!',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 16),
              Text(
                '🔍 **Šta nudi naša aplikacija?**',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'CG Kompas je jedinstveno rješenje koje vam omogućava da: \n'
                '- Pronađete sve događaje na jednom mjestu. \n'
                '- Pregledate sadržaje grupisane po kategorijama. \n'
                '- Pristupite slikama, komentarima i iskustvima drugih posjetilaca.',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 16),
              Text(
                '🌍 **Zašto odabrati CG Kompas?**',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Crna Gora je zemlja bogata prirodnim ljepotama, festivalima i događajima kulturnog karaktera, ali često nisu lako dostupni. Naša aplikacija omogućava da na brz i pregledan način otkrijete sve što ova predivna zemlja nudi.',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 16),
              Text(
                '🎉 **Izdvojeni događaji**',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'U aplikaciji možete pronaći informacije o najpoznatijim manifestacijama, kao što su:',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 8),
              Text(
                '- Dani planinskog cvijeća\n'
                '- Dani meda\n'
                '- Dani smokve\n'
                '- Maslinijada\n'
                '... i mnogi drugi događaji koji promovišu tradiciju, kulturu i istoriju Crne Gore.',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 16),
              Text(
                'CG Kompas – Vaš vodič kroz ljepotu, tradiciju i kulturu Crne Gore!',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Zatvori', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      );
    },
  );
}
