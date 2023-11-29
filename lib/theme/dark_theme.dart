

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const ColorScheme myColorScheme = ColorScheme(
  primary: Color(0xFF2C74B3),
  secondary: Color(0xFF205295),
  background: Color(0xFF144272),
  onBackground: Color(0xFF0A2647),
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onError: Colors.black,
  brightness: Brightness.light,
  surface: Colors.white,
  onSurface: Colors.green,
  error: Colors.red,
   

);

final TextTheme myTextTheme = TextTheme(
  bodyLarge: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.sp),
  bodyMedium: TextStyle(fontSize: 15.sp),
  bodySmall: TextStyle(fontWeight: FontWeight.bold,fontSize: 10.sp),
  // Agrega más estilos aquí
);

final ThemeData darkThemeFile=ThemeData.dark().copyWith(
  backgroundColor: myColorScheme.background,
  colorScheme: myColorScheme,
  
  appBarTheme: AppBarTheme().copyWith(
  ),
);