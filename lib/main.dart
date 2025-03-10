import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n.dart';
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
  String _languageCode = 'pl';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TriTravel',
      locale: Locale(_languageCode),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('pl', 'PL'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        L10nDelegate(),
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
      _languageCode = languageCode;
    });
  }

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
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
        title: Text(L10n.of(context)?.appTitle ?? 'TriTravel'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),  // PRZYWRÓCONA IKONA USTAWIEŃ ⚙️
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(L10n.of(context)?.menuLanguage ?? 'Language'),
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
          ),
        ],
      ),
      drawer: AppDrawer(
        onLanguageChange: onLanguageChange,
        attractions: attractions,
        onTabChanged: onTabChanged,
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: [
          MainScreen(attractions: attractions, onTabChanged: onTabChanged),
          AboutPage(onLanguageChange: onLanguageChange),  // Poprawione, żeby działała zmiana języka
          AttractionsPage(attractions: attractions),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onTabChanged,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: L10n.of(context)?.menuHome ?? 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: L10n.of(context)?.menuAbout ?? 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: L10n.of(context)?.menuAttractions ?? 'Attractions',
          ),
        ],
      ),
    );
  }
}

class AttractionsPage extends StatefulWidget {
  final List<Attraction> attractions;

  AttractionsPage({required this.attractions});

  @override
  _AttractionsPageState createState() => _AttractionsPageState();
}

class _AttractionsPageState extends State<AttractionsPage> {
  String selectedHashtag = 'All';

  @override
  Widget build(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;

    // Pobieramy wszystkie unikalne hashtagi + 'All'
    Set<String> hashtags = {'All'};
    for (var attraction in widget.attractions) {
      hashtags.addAll(attraction.hashtags);
    }

    // Tworzymy listę przycisków hashtagów
    List<Widget> hashtagWidgets = hashtags.map((hashtag) {
      return ChoiceChip(
        label: Text('#${L10n.getHashtag(hashtag, languageCode)}'),
        selected: selectedHashtag == hashtag,
        onSelected: (selected) {
          setState(() {
            selectedHashtag = hashtag;
          });
        },
      );
    }).toList();

    // Filtrowanie atrakcji na podstawie wybranego hashtagu
    List<Attraction> filteredAttractions = selectedHashtag == 'All'
        ? widget.attractions
        : widget.attractions.where((attraction) {
            return attraction.hashtags.contains(selectedHashtag);
          }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context)?.attractionsTitle ?? 'Attractions'),
      ),
      body: Column(
        children: [
          // Wyswietlanie hashtagów
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              children: hashtagWidgets,
            ),
          ),
          // Lista atrakcji
          Expanded(
            child: ListView.builder(
              itemCount: filteredAttractions.length,
              itemBuilder: (context, index) {
                final attraction = filteredAttractions[index];

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
                    title: Text(attraction.getTitle(languageCode)),
                    subtitle: Text(attraction.getShortDescription(languageCode)),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return FractionallySizedBox(
                            heightFactor: 0.9,
                            child: AttractionDetailView(
                              attraction: attraction, 
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AttractionDetailView extends StatelessWidget {
  final Attraction attraction;

  AttractionDetailView({required this.attraction});

  @override
  Widget build(BuildContext context) {
    // Pobieramy aktualnie ustawiony język
    String languageCode = Localizations.localeOf(context).languageCode;

    // Pobieramy tytuł i opis w odpowiednim języku
    String translatedTitle = attraction.getTitle(languageCode);
    String translatedShortDescription = attraction.getShortDescription(languageCode);
    String translatedLongDescription = attraction.getLongDescription(languageCode);

    return Center( // Wycentrowanie wszystkiego
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrowanie w pionie
          crossAxisAlignment: CrossAxisAlignment.center, // Centrowanie w poziomie
          children: [
            ClipRRect( // Zaokrąglone rogi obrazka (opcjonalne)
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                attraction.imageUrl,
                width: 300, // Zmniejszenie szerokości dla lepszego wyglądu
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              translatedTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center, // Wycentrowanie tekstu
            ),
            SizedBox(height: 12.5),
            Text(
              translatedShortDescription,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center, // Wycentrowanie tekstu
            ),
            SizedBox(height: 8),
            Text(
              translatedLongDescription,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center, // Wycentrowanie tekstu
            ),
          ],
        ),
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
              onTabChanged(2); // Przejdź do ekranu atrakcji
            },
            child: Text(L10n.of(context)?.seeAttractions ?? 'See Attractions'),
          ),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  final Function(String) onLanguageChange;

  AboutPage({required this.onLanguageChange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context)?.aboutTitle ?? 'About TriTravel'),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () => onLanguageChange('pl'),
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
      body: Center( // Wycentrowanie wszystkiego
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centrowanie w pionie
            crossAxisAlignment: CrossAxisAlignment.center, // Centrowanie w poziomie
            children: [
              Text(
                L10n.of(context)?.aboutTitle ?? 'About TriTravel',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center, // Wycentrowanie tekstu
              ),
              SizedBox(height: 16),
              Text(
                L10n.of(context)?.aboutText ?? 'TriTravel is an app for travel planning.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center, // Wycentrowanie tekstu
              ),
            ],
          ),
        ),
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
            child: Text(
              L10n.of(context)?.appTitle ?? 'TriTravel',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
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