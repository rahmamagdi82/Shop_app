import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/style/colors.dart';

ThemeData lightTheme()=>ThemeData(
  fontFamily: 'Jannah',
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  primarySwatch: defaultColor,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.deepPurple,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    elevation: 25.0,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    titleTextStyle: TextStyle(
      fontSize: 30.0,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 30.0,
    ),
    backgroundColor: Colors.white,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
);
