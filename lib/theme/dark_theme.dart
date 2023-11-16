

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const ColorScheme myColorScheme = ColorScheme(
  primary: Color(0xFF27374D),
  secondary: Color(0xFF526D82),
  background: Color(0xFF9DB2BF),
  onBackground: Color(0xFFDDE6ED),
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onError: Colors.black,
  brightness: Brightness.light,
  surface: Colors.green,
  onSurface: Colors.green,
  error: Colors.red,
   

);

final TextTheme myTextTheme = TextTheme(
  bodyMedium: TextStyle(fontSize: 25.sp),
  bodyLarge: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.sp),
  bodySmall: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp),
  // Agrega más estilos aquí
);

final ThemeData darkThemeFile=ThemeData.dark().copyWith(
  colorScheme: myColorScheme,
  
  appBarTheme: AppBarTheme().copyWith(
  ),
);