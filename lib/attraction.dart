import 'l10n.dart'; // Importujemy plik z tłumaczeniami

class Attraction {
  final String imageUrl;
  final Map<String, String> title;
  final String address;
  final Map<String, String> s_description;
  final Map<String, String> l_description;
  final List<String> hashtags;
  final List<String> additionalImages;

  Attraction({
    required this.imageUrl,
    required this.title,
    required this.address,
    required this.s_description,
    required this.l_description,
    required this.hashtags,
    this.additionalImages = const [],
  });

   String getTitle(String languageCode) {
    return title[languageCode] ?? title['en'] ?? 'Unknown Title';
  }

  String getShortDescription(String languageCode) {
    return s_description[languageCode] ?? s_description['en'] ?? 'No description available';
  }

  String getLongDescription(String languageCode) {
    return l_description[languageCode] ?? l_description['en'] ?? 'No detailed description available';
  }

  String getFormattedAddress() {
    return address;
  }
}
