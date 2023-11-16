import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AppTheme { light, dark }

class SettingsApp extends ChangeNotifier {
  SettingsApp([this._theme]);
  AppTheme? _theme;

  AppTheme? get theme => _theme;
  set theme(AppTheme? t) {
    _theme = t;
    notifyListeners();
  }
}