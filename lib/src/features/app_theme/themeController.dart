import 'package:flutter/material.dart';
import 'theme.dart';


enum AppTheme { Light, Dark, Glass }

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = AppThemes.lightTheme;
  AppTheme _currentTheme = AppTheme.Light;

  ThemeData get themeData => _themeData;
  AppTheme get currentTheme => _currentTheme;

  void setTheme(AppTheme theme) {
    _currentTheme = theme;
    switch (theme) {
      case AppTheme.Light:
        _themeData = AppThemes.lightTheme;
        break;
      case AppTheme.Dark:
        _themeData = AppThemes.darkTheme;
        break;
      case AppTheme.Glass:
        _themeData = AppThemes.glassTheme;
        break;
    }
    notifyListeners();
  }
}
