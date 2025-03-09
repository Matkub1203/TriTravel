import 'package:flutter/material.dart';
import 'package:my_app/l10n.dart';
import 'l10n.dart'; 

class AboutPage extends StatelessWidget {
  final Function(String) onLanguageChange;

  AboutPage({required this.onLanguageChange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.getText(context, 'about_title')),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () => onLanguageChange('pl'),  // Zmieniamy język za pomocą przekazanej funkcji
                child: Text(
                  'PL',
                  style: TextStyle(
                    color: Localizations.localeOf(context).languageCode == 'pl' ? Colors.blue : Colors.black,
                    fontWeight: Localizations.localeOf(context).languageCode == 'pl' ? FontWeight.bold : FontWeight.normal,
                    decoration: Localizations.localeOf(context).languageCode == 'pl' ? TextDecoration.underline : null,
                  ),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () => onLanguageChange('en'),
                child: Text(
                  'ENG',
                  style: TextStyle(
                    color: Localizations.localeOf(context).languageCode == 'en' ? Colors.blue : Colors.black,
                    fontWeight: Localizations.localeOf(context).languageCode == 'en' ? FontWeight.bold : FontWeight.normal,
                    decoration: Localizations.localeOf(context).languageCode == 'en' ? TextDecoration.underline : null,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: AppDrawer(onLanguageChange: onLanguageChange),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              L10n.getText(context, 'about_title'),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              L10n.getText(context, 'about_text'),
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  final Function(String) onLanguageChange;

  AppDrawer({required this.onLanguageChange});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('TriTravel', style: TextStyle(color: Colors.white, fontSize: 24)),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text(L10n.getText(context, 'menu_home')),
            onTap: () {
              // Używamy Navigator.pop(), aby wrócić do strony głównej
              Navigator.pop(context); // Zamyka Drawer
              Navigator.popUntil(context, ModalRoute.withName('/')); // Powrót do głównej strony
            },
          ),
          ListTile(
            title: Text(L10n.getText(context, 'menu_about')),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage(onLanguageChange: onLanguageChange)),
              );
            },
          ),
        ],
      ),
    );
  }
}
