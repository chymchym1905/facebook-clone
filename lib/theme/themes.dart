import 'package:flutter/material.dart';

const Color white = Color.fromARGB(255, 255, 255, 255);
const Color blue = Color.fromRGBO(59, 127, 210, 1);


ThemeData light = ThemeData(
  fontFamily: 'HyWenHei',
  // brightness: Brightness.light,
  scaffoldBackgroundColor: Color.fromARGB(235, 255, 255, 255),
  textTheme: const TextTheme(
    titleLarge: TextStyle(//feed name
      letterSpacing: -1.0,
      color: Colors.black,
    ),
    labelSmall: TextStyle( //likes
      color: Colors.grey,
      letterSpacing: -0.2,
    ),
    labelLarge: TextStyle( //content
      color: Colors.black,
      letterSpacing: -0.8
    ),
    titleMedium: TextStyle( //Poster
      letterSpacing: -1.0
    ),
    bodySmall: TextStyle(
      color: Color.fromARGB(255, 49, 48, 48),
      letterSpacing: -0.2,
    ),
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
    foregroundColor: Color.fromRGBO(0, 0, 0, 1),
  ),
  tabBarTheme: const TabBarTheme(
    unselectedLabelColor: Color.fromRGBO(121, 123, 125, 1),
    dividerColor: Color.fromRGBO(59, 127, 210, 1),
    labelColor: Color.fromRGBO(59, 127, 210, 1),
  ),
  
  // colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
);

ThemeData dark = ThemeData(
  fontFamily: 'HyWenHei',
  // brightness: Brightness.dark,
  scaffoldBackgroundColor: Color.fromARGB(235, 0, 0, 0),
  // colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(161, 158, 158, 158)),
  textTheme: const TextTheme(

    // bodySmall: TextStyle(
    //   color: Colors.grey,
    // ),
    // labelMedium: TextStyle(
    //   color: Colors.black,
    // ),
    
    titleLarge: TextStyle(//feed name
      letterSpacing: -1.0,
      color: Colors.white,
    ),
    labelSmall: TextStyle( //likes
      color: Colors.grey,
      letterSpacing: -0.2,
    ),
    labelLarge: TextStyle( //content
      color: Color.fromRGBO(255, 255, 255, 1),
      letterSpacing: -0.8
    ),
    titleMedium: TextStyle( //Poster
      color: Color.fromRGBO(255, 255, 255, 1),
      letterSpacing: -1.0
    ),
    bodySmall: TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      letterSpacing: -0.2,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 38, 38, 38),
    foregroundColor: Color.fromRGBO(255, 255, 255, 1),
  ),
  tabBarTheme: const TabBarTheme(
    unselectedLabelColor: Color.fromRGBO(121, 123, 125, 1),
    dividerColor: Color.fromRGBO(59, 127, 210, 1),
    labelColor: Color.fromRGBO(59, 127, 210, 1),
  ),

);

class ThemeProvider with ChangeNotifier {
  var _theme = light;

  ThemeData get themeMode => _theme;

  dynamic toggleTheme(bool isDark) {
    _theme = isDark ? dark : light;
    notifyListeners();
  }
}