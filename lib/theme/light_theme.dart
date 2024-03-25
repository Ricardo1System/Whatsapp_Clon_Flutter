

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const ColorScheme myColorScheme = ColorScheme(
  // primary: Color(0xFFC63D2F),
  // secondary: Color(0xFFE25E3E),
  // onBackground: Color(0xFFFFBB5C),
  // background: Color(0xFFFF9B50),
  primary: Color.fromARGB(255, 78, 101, 190),
  secondary: Color(0xFF8EA7E9),
  background: Color(0xFFE5E0FF),
  onBackground: Color(0xFFFFF2F2),
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onError: Colors.white,
  brightness: Brightness.light,
  surface: Color.fromARGB(255, 78, 101, 190),
  onSurface: Color(0xFFFFF2F2),
  error: Colors.red, 

);

final TextTheme myTextTheme = TextTheme(
  bodyLarge: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.sp),
  bodyMedium: TextStyle(fontSize: 15.sp),
  bodySmall: TextStyle(fontWeight: FontWeight.bold,fontSize: 10.sp),
  // Agrega más estilos aquí
);

final ThemeData lightThemeFile = ThemeData.light().copyWith(
  // primaryColor: myColorScheme.onBackground,
  colorScheme: myColorScheme,
  // textTheme: myTextTheme,
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: const TextStyle(
      color: Colors.red,
      fontSize: 20.0,
    ),
    hintStyle: const TextStyle(
      color: Colors.grey,
      fontSize: 16.0,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 2.0,
      ),
    ),
  ),
);



  
