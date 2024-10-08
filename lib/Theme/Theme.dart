import 'package:flutter/material.dart';


class ThemeChanger with ChangeNotifier{
  ThemeData _themeData;

  ThemeChanger(this._themeData);

  getThemeData() => _themeData;

  setThemeData(ThemeData theme) {
    this._themeData = theme;
    notifyListeners();
  }
}