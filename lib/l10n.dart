import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('pl'),
  ];

  static String getText(BuildContext context, String key) {
    final locale = Localizations.localeOf(context).languageCode;

    final translations = {
      'en': {
        'app_title': 'TriTravel',
        'home_welcome': 'Welcome to TriTravel!',
        'home_description': 'Discover the best places and plan your trips with TriTravel!',
        'menu_home': 'Home',
        'menu_about': 'About Us',
        'menu_language': 'Language',
        'about_title': 'About Us - TriTravel',
        'about_text': 'Learn more about the features and vision of TriTravel!',
      },
      'pl': {
        'app_title': 'TriTravel',
        'home_welcome': 'Witaj w TriTravel!',
        'home_description': 'Odkrywaj najlepsze miejsca i planuj podróże z TriTravel!',
        'menu_home': 'Strona Główna',
        'menu_about': 'O nas',
        'menu_language': 'Język',
        'about_title': 'O TriTravel',
        'about_text': 'TriTravel to najlepszy towarzysz w planowaniu podróży.',
      },
    };

    return translations[locale]?[key] ?? key;
  }
}
