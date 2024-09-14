import "package:flutter/material.dart";

class Themeprovider with ChangeNotifier {
  late ThemeMode _mode;
  ThemeMode get mode => _mode;
  Themeprovider({
    ThemeMode mode = ThemeMode.dark,
  }) : _mode = mode;

  void toggleMode() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
