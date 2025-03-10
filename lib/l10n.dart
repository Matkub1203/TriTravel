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
      return 'O nas';
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
      return 'About Us';
    } else if (locale.languageCode == 'pl') {
      return 'O nas';
    }
    return 'About Us';
  }

  String get aboutText {
    if (locale.languageCode == 'en') {
      return 'We are a group of students from III High School in Gdynia who love the Tri-City area but also notice opportunities for improvement and facilitation of tourists stays, residents lives, as well as the promotion of the tourist, cultural, social, and historical values of the agglomeration. The Junior Biznes Teen 8 competition turned out to be a perfect opportunity to combine our IT, language, management, creativity, and innovation skills to create something exceptional with a group of friends.';
    } else if (locale.languageCode == 'pl') {
      return 'Jesteśmy grupą uczniów z III LO w Gdyni, którzy kochają Trójmiasto, ale też zauważają możliwości poprawy i ułatwienia pobytu turystów, życia mieszkańców oraz popularyzacji walorów turystycznych, kulturowych, społecznych i historycznych aglomeracji. Konkurs Junior Biznes Teen 8 okazał się doskonałą okazją do połączenia naszych zdolności informatycznych, językowych, zarządzania, kreatywności i innowacyjności do stworzenia w grupie przyjaciół czegoś wyjątkowego.';
    }
    return 'We are a group of students from III High School in Gdynia who love the Tri-City area but also notice opportunities for improvement and facilitation of tourists stays, residents lives, as well as the promotion of the tourist, cultural, social, and historical values of the agglomeration. The Junior Biznes Teen 8 competition turned out to be a perfect opportunity to combine our IT, language, management, creativity, and innovation skills to create something exceptional with a group of friends.';
  }
  
  static Map<String, Map<String, String>> hashtags = {
    'en': {
      'All': 'All',
      'Museum': 'Museum',
      'Science': 'Science',
      'Culture': 'Culture',
    },
    'pl': {
      'All': 'Wszystko',
      'Museum': 'Muzea',
      'Science': 'Science',
      'Culture': 'Kultura',
    },
  };

  // Funkcja do pobierania przetłumaczonego hashtaga
  static String getHashtag(String hashtag, String languageCode) {
    return hashtags[languageCode]?[hashtag] ?? hashtag;
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
