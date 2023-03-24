import 'package:flutter/material.dart';

import 'constants.dart';

final lightTheme = ThemeData.light().copyWith(
  appBarTheme: AppBarTheme(
    elevation: 0,
  ),
  primaryColor: kPrimaryColor,
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
    ),
    bodyText2: TextStyle(
      color: Colors.black,
      fontSize: 17,
    ),
    button: TextStyle(
      color: Colors.blueAccent,
      fontSize: 15,
    ),
    subtitle1: TextStyle(
      color: Colors.black38,
      fontSize: 15,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: const Color(0xFFF5F6F9),
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  hoverColor: const Color(0xFFDADADA).withOpacity(0.15),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: kPrimaryColor,
    unselectedItemColor: Colors.grey.withOpacity(.8),
    type: BottomNavigationBarType.fixed,
  ),
);

final darkTheme = ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.white,
      ),
      bodyText2: TextStyle(
        color: Colors.white,
        fontSize: 17,
      ),
      button: TextStyle(
        color: Colors.greenAccent,
        fontSize: 15,
      ),
      subtitle1: TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.grey.shade800,
      ),
    ),
    hoverColor: const Color(0xFFDADADA).withOpacity(0),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey.shade800,
      selectedItemColor: Colors.greenAccent,
      unselectedItemColor: Colors.white,
      type: BottomNavigationBarType.fixed,
    ),
    appBarTheme: AppBarTheme().copyWith(
      elevation: 0,
    ));
