import 'package:flutter/material.dart';
import 'attraction.dart';

class AttractionsPage extends StatelessWidget {
  final List<Attraction> attractions;

  AttractionsPage({required this.attractions});

  @override
  Widget build(BuildContext context) {
    // Pobieramy aktualnie ustawiony język
    String languageCode = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text('Attractions'),
        automaticallyImplyLeading: false,  // Usuwamy strzałkę powrotu
      ),
      body: ListView.builder(
        itemCount: attractions.length,
        itemBuilder: (context, index) {
          final attraction = attractions[index];

          // Pobieramy tytuł i opis w odpowiednim języku
          String translatedTitle = attraction.getTitle(languageCode);
          String translatedShortDescription = attraction.getShortDescription(languageCode);
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
              title: Text(translatedTitle),  // Przetłumaczony tytuł
              subtitle: Text(translatedShortDescription),  // Przetłumaczony opis
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return FractionallySizedBox(
                      heightFactor: 0.9,  // 80% wysokości ekranu
                      child: AttractionDetailView(attraction: attraction),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class AttractionDetailView extends StatelessWidget {
  final Attraction attraction;

  AttractionDetailView({required this.attraction});

  @override
  Widget build(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;

    String translatedTitle = attraction.getTitle(languageCode);
    String translatedShortDescription = attraction.getShortDescription(languageCode);
    String translatedLongDescription = attraction.getLongDescription(languageCode);

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Główne zdjęcie atrakcji
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  attraction.imageUrl,
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),

              // Tytuł
              Text(
                translatedTitle,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.5),

              // Krótki opis
              Text(
                translatedShortDescription,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),

              // Długi opis
              Text(
                translatedLongDescription,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),

              // **Dodatkowe zdjęcia**
              if (attraction.additionalImages.isNotEmpty) ...[
                Text(
                  "Galeria",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Column(
                  children: attraction.additionalImages.map((imagePath) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          imagePath,
                          width: 300,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Text('Nie udało się załadować zdjęcia: $imagePath');
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
