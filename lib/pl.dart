class AppLocalization {
  static const Map<String, String> _localizedValues = {
    'app_title': 'TriTravel',
    'menu_home': 'Strona główna',
    'menu_about': 'O nas',
    'menu_attractions': 'Atrakcje',
    'attractions_title': 'Atrakcje',
    'about_title': 'O nas',
    'about_text': 'Witamy w aplikacji TriTravel!',
  };

  String getText(String key) {
    return _localizedValues[key] ?? key;
  }
}
