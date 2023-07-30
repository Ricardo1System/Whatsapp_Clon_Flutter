import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'shared_preferences/preferences_app_theme.dart';

class AppKiiubitTheme extends ChangeNotifier{

  static bool _isDarkMode = PreferencesAppTheme.isDarkMode;
  bool isDarkMode;
  ThemeData currentTheme;

  AppKiiubitTheme({
    required bool enabledDarkMode
  }) : isDarkMode = enabledDarkMode, currentTheme = enabledDarkMode ? darkTheme : lightTheme;

  setDarkMode() {
    isDarkMode = true;
    currentTheme = darkTheme;

    notifyListeners();
  }

  setLightMode() {
    isDarkMode = false;
    currentTheme = lightTheme;

    notifyListeners();
  }

  static void refreshTheme() {
    _isDarkMode = PreferencesAppTheme.isDarkMode;
  }


  // Colores Light
  static const Color _lightBackground = Color.fromARGB(255, 235, 235, 235);

  static const Color _lightPrimary = Color.fromARGB(255, 250, 81, 112); // Rojo Sangrita PANTONE P 55-8 C #e5133a
  static const Color _lightSecondary = Color.fromARGB(255, 250, 160, 81); // Naranja medio PANTONE P 27-8 C #ef7911
  static const Color _lightTertiary = Color.fromARGB(255, 243, 202, 69); // Amarillo Lima PANTONE P 10-16 C #dfab00

  static const Color _lightRatingStars = Colors.green;


  // Colores Dark
  static const Color _darkBackground = Color(0xFF121212);

  static const Color _darkPrimary = Color.fromARGB(255, 73, 92, 131 ); // Rojo Sangrita PANTONE P 55-8 C #e5133a
  static const Color _darkSecondary = Color.fromARGB(255, 122, 134, 182); // Naranja medio PANTONE P 27-8 C #ef7911
  static const Color _darkTertiary = Color.fromARGB(255, 168, 164, 206); // Amarillo Lima PANTONE P 10-16 C #dfab00

  static const Color _darkRatingStars = Colors.lightGreenAccent;

  // Color del lienzo
  static Color get background => _isDarkMode ? _darkBackground : _lightBackground;

  // Colores de fondo componentes 
  static Color get backgroundWidget => _isDarkMode ? const Color.fromARGB(255, 66, 66, 66) : Colors.white;

  // Colores principales degradado
  static Color get primary => _isDarkMode ? _darkPrimary : _lightPrimary;
  static Color get secondary => _isDarkMode ? _darkSecondary : _lightSecondary;
  static Color get tertiary => _isDarkMode ? _darkTertiary : _lightTertiary;

  // Colores de texto
  static Color get textPrimary => primary;
  static Color get textColor => _isDarkMode ? Colors.white : Colors.black87;
  static Color get textColorOpaque => Colors.black54;

  // Colores de estrellas 
  static Color get ratingStars => _isDarkMode ? _darkRatingStars : _lightRatingStars;


  static List<Color> get gradientColors => [
    primary,
    secondary,
  ];

  // Títulos color primario
  static TextStyle get textTitle20 => TextStyle(
    fontFamily: 'Ginóra Sans',
    color: textPrimary,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold
  );

  static TextStyle get textTitle18 => TextStyle(
    fontFamily: 'Ginóra Sans',
    color: textPrimary, 
    fontSize: 18.sp,
    fontWeight: FontWeight.bold
  );

  static TextStyle get textTitle16 => TextStyle(
    fontFamily: 'Ginóra Sans',
    color: textPrimary,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold
  );

  static TextStyle get textTitle14 => TextStyle(
    fontFamily: 'Ginóra Sans',
    color: textPrimary,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold
  );

  // Texto normal color primario
  static TextStyle get textClassic20 => TextStyle(
    fontFamily: 'Ginóra Sans',
    color: textPrimary,
    fontSize: 20.sp,
  );
  
  static TextStyle get textClassic18 => TextStyle(
    fontFamily: 'Ginóra Sans',
    color: textPrimary,
    // fontSize: 18.sp,
  );
  static TextStyle get textClassic16 => TextStyle(
    fontFamily: 'Ginóra Sans',
    color: textPrimary,
    fontSize: 16.sp,
  );
  
  static TextStyle get textClassic14 => TextStyle(
    fontFamily: 'Ginóra Sans',
    color: textPrimary,
    fontSize: 14.sp,
  );

  // Texto normal
  static TextStyle get textClassicBlack20 => TextStyle(
    fontFamily: 'Ginóra Sans',
    color: textColor,
    fontSize: 20.sp,
  );
  
  static TextStyle get textClassicBlack18 => TextStyle(
    fontFamily: 'Ginóra Sans',
    color: textColor,
    fontSize: 18.sp,
  );
  
  static TextStyle get textClassicBlack16 => TextStyle(
    fontFamily: 'Ginóra Sans',
    color: textColor,
    fontSize: 16.sp,
  );
  
  static TextStyle get textClassicBlack14 => TextStyle(
    fontFamily: 'Ginóra Sans',
    color: textColor,
    fontSize: 14.sp,
  );

  // Texto normal color opaco
  static TextStyle get textOpaque20 => TextStyle(
    fontFamily: 'Ginóra Sans',
    color: textColorOpaque,
    fontSize: 20.sp,
  );
  
  static TextStyle get textOpaque18 => TextStyle(
    fontFamily: 'Ginóra Sans',
    color: textColorOpaque,
    fontSize: 18.sp,
  );
  
  static TextStyle get textOpaque16 => TextStyle(
    fontFamily: 'Ginóra Sans',
    color: textColorOpaque,
    fontSize: 16.sp,
  );
  
  static TextStyle get textOpaque14 => TextStyle(
    fontFamily: 'Ginóra Sans',
    color: textColorOpaque,
    fontSize: 14.sp,
  );


  static final lightTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    platform: TargetPlatform.iOS,
    // AppBar Theme

    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    ),

    scaffoldBackgroundColor: _lightBackground,

    buttonTheme: ButtonThemeData(buttonColor: primary),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(primary),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      helperStyle: TextStyle(
          color: AppKiiubitTheme.primary,
          fontSize: 14,
          fontFamily: 'GOTHAMHTF',
          letterSpacing: -0.4),
      hintStyle: TextStyle(color: AppKiiubitTheme.primary, fontSize: 14),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppKiiubitTheme
                .primary, // Aquí puedes cambiar el color del borde
          ),
          borderRadius: BorderRadius.circular(8.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppKiiubitTheme
                .primary, // Aquí puedes cambiar el color del borde
          ),
          borderRadius: BorderRadius.circular(8.0)),
    ),
  );

  static final darkTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    platform: TargetPlatform.iOS,
    // AppBar Theme

    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    ),

    scaffoldBackgroundColor: _darkBackground,

    buttonTheme: ButtonThemeData(buttonColor: primary),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(primary),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      helperStyle: TextStyle(
          color: AppKiiubitTheme.primary,
          fontSize: 14,
          fontFamily: 'GOTHAMHTF',
          letterSpacing: -0.4),
      hintStyle: TextStyle(color: AppKiiubitTheme.primary, fontSize: 14),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppKiiubitTheme
                .primary, // Aquí puedes cambiar el color del borde
          ),
          borderRadius: BorderRadius.circular(8.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppKiiubitTheme
                .primary, // Aquí puedes cambiar el color del borde
          ),
          borderRadius: BorderRadius.circular(8.0)),
    ),
  );
}
