import 'package:flutter/material.dart';
import 'package:my_app/l10n.dart';  // Zaimportuj klasę L10n
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(TriTravelApp());
}

class TriTravelApp extends StatefulWidget {
  @override
  _TriTravelAppState createState() => _TriTravelAppState();
}

class _TriTravelAppState extends State<TriTravelApp> {
  String _languageCode = 'en'; // Domyślny język to angielski
  int _selectedIndex = 0; // Indeks wybranego widoku

  void _onLanguageChange(String newLanguageCode) {
    setState(() {
      _languageCode = newLanguageCode;
    });
  }

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TriTravel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('pl', 'PL'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: Locale(_languageCode),  // Zmieniamy lokalizację na dynamiczną
      home: HomePage(
        onLanguageChange: _onLanguageChange,
        onTabChanged: _onTabChanged,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final Function(String) onLanguageChange;
  final Function(int) onTabChanged;
  final int selectedIndex;

  HomePage({required this.onLanguageChange, required this.onTabChanged, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.getText(context, 'app_title')),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(L10n.getText(context, 'menu_language')),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text('Polski'),
                          onTap: () {
                            onLanguageChange('pl');
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text('English'),
                          onTap: () {
                            onLanguageChange('en');
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
      drawer: AppDrawer(onLanguageChange: onLanguageChange),
      body: IndexedStack(
        index: selectedIndex,  // Wybieramy aktualny widok na podstawie indeksu
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Dodajemy logo nad tekstem
                Image.asset(
                  'assets/images/logo_tritravel.jpg', // Ścieżka do logo
                  height: 300, // Wysokość logo
                ),
                SizedBox(height: 20), // Przerwa między logo a tekstem
                Text(L10n.getText(context, 'home_welcome')),
                Text(L10n.getText(context, 'home_description')),
              ],
            ),
          ),
          AboutPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onTabChanged,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: L10n.getText(context, 'menu_home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: L10n.getText(context, 'menu_about'),
          ),
        ],
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
            child: Text(L10n.getText(context, 'app_title'), style: TextStyle(color: Colors.white, fontSize: 24)),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text(L10n.getText(context, 'menu_home')),
            onTap: () {
              Navigator.pop(context); // Zamyka Drawer
              // Zmiana widoku na HomePage
              (context as Element).markNeedsBuild();
            },
          ),
          ListTile(
            title: Text(L10n.getText(context, 'menu_about')),
            onTap: () {
              Navigator.pop(context); // Zamyka Drawer
              // Zmiana widoku na AboutPage
              (context as Element).markNeedsBuild();
            },
          ),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
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
