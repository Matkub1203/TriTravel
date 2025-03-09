import 'package:flutter/material.dart';
import 'package:my_app/l10n.dart';  // Zależność do pliku L10n
import 'main.dart'; // Jeśli 'Attraction' jest w main.dart, zaimportuj ten plik.
import 'attraction.dart';

class AttractionsPage extends StatelessWidget {
  final List<Attraction> attractions;  // Parametr do przyjęcia listy atrakcji

  // Konstruktor
  AttractionsPage({required this.attractions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attractions'), // Możesz tutaj dodać lokalizację
      ),
      body: ListView.builder(
        itemCount: attractions.length,
        itemBuilder: (context, index) {
          final attraction = attractions[index];
          return ListTile(
            title: Text(attraction.title),
            subtitle: Text(attraction.description),
            leading: Image.asset(attraction.imageUrl),
          );
        },
      ),
    );
  }
}

