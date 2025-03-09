import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n.dart';  // Zaimportuj wygenerowane pliki lokalizacji
import 'attractions_page.dart';
import 'attraction.dart';
import 'attractions_list.dart';

void main() {
  runApp(TriTravelApp());
}

class TriTravelApp extends StatefulWidget {
  @override
  _TriTravelAppState createState() => _TriTravelAppState();
}

class _TriTravelAppState extends State<TriTravelApp> {
  int _selectedIndex = 0;
  String _languageCode = 'en';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TriTravel',
      locale: Locale(_languageCode),  // Ustawiamy język na podstawie _languageCode
      supportedLocales: [
        Locale('en', 'US'),
        Locale('pl', 'PL'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        L10nDelegate(),  // Używamy naszej klasy delegata dla L10n
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        onLanguageChange: _changeLanguage,
        onTabChanged: _onTabChanged,
        selectedIndex: _selectedIndex,
        attractions: attractions,
      ),
    );
  }

  void _changeLanguage(String languageCode) {
    setState(() {
      _languageCode = languageCode;  // Zmieniamy język
    });
  }

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;  // Zmieniamy wybrany ekran
    });
  }
}

class HomePage extends StatelessWidget {
  final Function(String) onLanguageChange;
  final Function(int) onTabChanged;
  final int selectedIndex;
  final List<Attraction> attractions;

  HomePage({
    required this.onLanguageChange,
    required this.onTabChanged,
    required this.selectedIndex,
    required this.attractions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context)?.appTitle ?? 'TriTravel'),  // Używamy L10n
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(L10n.of(context)?.menuLanguage ?? 'Language'),  // Zmieniamy metodę na wygenerowaną
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
      drawer: AppDrawer(
        onLanguageChange: onLanguageChange,
        attractions: attractions,
        onTabChanged: onTabChanged, // Przekazywanie funkcji do menu bocznego
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: [
          MainScreen(attractions: attractions, onTabChanged: onTabChanged),
          AboutPage(),
          AttractionsPage(attractions: attractions),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onTabChanged,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: L10n.of(context)?.menuHome ?? 'Home',  // Używamy L10n
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: L10n.of(context)?.menuAbout ?? 'About',  // Używamy L10n
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: L10n.of(context)?.menuAttractions ?? 'Attractions',  // Używamy L10n
          ),
        ],
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  final Function(String) onLanguageChange;
  final List<Attraction> attractions;
  final Function(int) onTabChanged;

  AppDrawer({
    required this.onLanguageChange,
    required this.attractions,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(L10n.of(context)?.appTitle ?? 'TriTravel'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text(L10n.of(context)?.menuHome ?? 'Home'),
            onTap: () {
              onTabChanged(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(L10n.of(context)?.menuAbout ?? 'About'),
            onTap: () {
              onTabChanged(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(L10n.of(context)?.menuAttractions ?? 'Attractions'),
            onTap: () {
              onTabChanged(2);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  final List<Attraction> attractions;
  final Function(int) onTabChanged;

  MainScreen({required this.attractions, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo_tritravel.jpg',
            height: 300,
          ),
          SizedBox(height: 20),
          Text(
            L10n.of(context)?.homeWelcome ?? 'Welcome to TriTravel!',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            L10n.of(context)?.homeDescription ?? 'Explore the most beautiful places!',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              onTabChanged(2); // Ustawiamy zakładkę na "atrakcje"
            },
            child: Text(L10n.of(context)?.seeAttractions ?? 'See Attractions'),
          ),
        ],
      ),
    );
  }
}

class AttractionsPage extends StatelessWidget {
  final List<Attraction> attractions;

  AttractionsPage({required this.attractions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context)?.attractionsTitle ?? 'Attractions'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: attractions.length,
        itemBuilder: (context, index) {
          final attraction = attractions[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: Image.asset(
                attraction.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              title: Text(attraction.title),
              subtitle: Text(attraction.description),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AttractionDetailPage(attraction: attraction),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class AttractionDetailPage extends StatelessWidget {
  final Attraction attraction;

  AttractionDetailPage({required this.attraction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(attraction.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(attraction.imageUrl),
            SizedBox(height: 16),
            Text(
              attraction.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              attraction.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
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
              L10n.of(context)?.aboutTitle ?? 'About TriTravel',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              L10n.of(context)?.aboutText ?? 'TriTravel is an app for travel planning.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
