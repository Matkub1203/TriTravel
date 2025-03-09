import 'package:flutter/material.dart';

class L10n {
  final Locale locale;

  // Konstruktor przyjmujący locale
  L10n(this.locale);

  // Funkcja, która zwraca tłumaczenie w zależności od języka
  static L10n? of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  // Wybór tekstu w zależności od języka
  String get appTitle {
    if (locale.languageCode == 'en') {
      return 'TriTravel';
    } else if (locale.languageCode == 'pl') {
      return 'TriTravel';
    }
    return 'TriTravel';  // Domyślny tytuł
  }

  String get menuLanguage {
    if (locale.languageCode == 'en') {
      return 'Language';
    } else if (locale.languageCode == 'pl') {
      return 'Język';
    }
    return 'Language';
  }

  String get menuHome {
    if (locale.languageCode == 'en') {
      return 'Home';
    } else if (locale.languageCode == 'pl') {
      return 'Strona główna';
    }
    return 'Home';
  }

  String get menuAbout {
    if (locale.languageCode == 'en') {
      return 'About';
    } else if (locale.languageCode == 'pl') {
      return 'O aplikacji';
    }
    return 'About';
  }

  String get menuAttractions {
    if (locale.languageCode == 'en') {
      return 'Attractions';
    } else if (locale.languageCode == 'pl') {
      return 'Atrakcje';
    }
    return 'Attractions';
  }

  String get homeWelcome {
    if (locale.languageCode == 'en') {
      return 'Welcome to TriTravel!';
    } else if (locale.languageCode == 'pl') {
      return 'Witaj w TriTravel!';
    }
    return 'Welcome to TriTravel!';
  }

  String get homeDescription {
    if (locale.languageCode == 'en') {
      return 'Discover the most beautiful places!';
    } else if (locale.languageCode == 'pl') {
      return 'Poznaj najpiękniejsze miejsca!';
    }
    return 'Discover the most beautiful places!';
  }

  String get seeAttractions {
    if (locale.languageCode == 'en') {
      return 'See Attractions';
    } else if (locale.languageCode == 'pl') {
      return 'Zobacz atrakcje';
    }
    return 'See Attractions';
  }

  String get attractionsTitle {
    if (locale.languageCode == 'en') {
      return 'Tourist Attractions';
    } else if (locale.languageCode == 'pl') {
      return 'Atrakcje turystyczne';
    }
    return 'Tourist Attractions';
  }

  String get aboutTitle {
    if (locale.languageCode == 'en') {
      return 'About the App';
    } else if (locale.languageCode == 'pl') {
      return 'O aplikacji';
    }
    return 'About the App';
  }

  String get aboutText {
    if (locale.languageCode == 'en') {
      return 'TriTravel is an app for planning trips.';
    } else if (locale.languageCode == 'pl') {
      return 'TriTravel to aplikacja do planowania podróży.';
    }
    return 'TriTravel is an app for planning trips.';
  }
}

class L10nDelegate extends LocalizationsDelegate<L10n> {
  const L10nDelegate();

  @override
  bool isSupported(Locale locale) {
    // Obsługujemy języki: angielski i polski
    return ['en', 'pl'].contains(locale.languageCode);
  }

  @override
  Future<L10n> load(Locale locale) async {
    // Zwracamy instancję L10n z odpowiednim językiem
    return L10n(locale);
  }

  @override
  bool shouldReload(L10nDelegate old) => false;
}
