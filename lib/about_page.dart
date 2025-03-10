import 'package:flutter/material.dart';
import 'l10n.dart';

class AboutPage extends StatelessWidget {
  final Function(String) onLanguageChange;

  AboutPage({required this.onLanguageChange});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;  // Pobieramy instancję L10n

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.aboutTitle),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: [
                _languageButton(context, 'pl'),
                SizedBox(width: 10),
                _languageButton(context, 'en'),
              ],
            ),
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
              l10n.aboutTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              l10n.aboutText,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _languageButton(BuildContext context, String languageCode) {
    bool isSelected = Localizations.localeOf(context).languageCode == languageCode;
    return GestureDetector(
      onTap: () => onLanguageChange(languageCode),
      child: Text(
        languageCode.toUpperCase(),
        style: TextStyle(
          color: isSelected ? Colors.blue : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          decoration: isSelected ? TextDecoration.underline : null,
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
    final l10n = L10n.of(context)!;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('TriTravel', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            title: Text(l10n.menuHome),
            onTap: () {
              Navigator.pop(context);
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
          ListTile(
            title: Text(l10n.menuAbout),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name != '/about') {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage(onLanguageChange: onLanguageChange)),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
