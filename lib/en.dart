class AppLocalization {
  static const Map<String, String> _localizedValues = {
    'app_title': 'TriTravel',
    'menu_home': 'Home',
    'menu_about': 'About',
    'menu_attractions': 'Attractions',
    'attractions_title': 'Attractions',
    'about_title': 'About Us',
    'about_text': 'Welcome to TriTravel app!',
  };

  String getText(String key) {
    return _localizedValues[key] ?? key;
  }
}
