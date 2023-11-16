



import 'package:flutter/material.dart';
import 'package:whatsapp_clone/theme/dark_theme.dart';
import 'package:whatsapp_clone/theme/light_theme.dart';

class ThemeChange with ChangeNotifier {
  ThemeChange(int theme){
    switch(theme){
    case 1:
     _darkTheme=false;
      _currentTheme=lightThemeFile ;
      break;
    case 2:
     _darkTheme=true;
      _currentTheme=darkThemeFile;
      break;
    default:
     _darkTheme=false;
      _currentTheme=lightThemeFile ;
      break;
    }  
    
  }

  ThemeData _currentTheme=ThemeData.light();

  ThemeData get currenttheme=>_currentTheme;
  bool get darkTheme=>_darkTheme;
  bool _darkTheme = false;

  set darkTheme(bool val){
    if (val) {
       _darkTheme=true;
      _currentTheme=darkThemeFile;
    }else{
       _darkTheme=false;
      _currentTheme=lightThemeFile ;
    }
    notifyListeners();
  }
  // set customTheme(bool val){
  //   if (val) {
  //   }else{
  //   }
  //   notifyListeners();
  // }

}


