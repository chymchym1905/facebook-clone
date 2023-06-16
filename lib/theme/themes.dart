import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'HyWenHei',
  // brightness: Brightness.light,
  scaffoldBackgroundColor: Color.fromARGB(235, 244, 247, 245),
  textTheme: const TextTheme(

    // bodySmall: TextStyle(
    //   color: Colors.grey,
    // ),
    // labelMedium: TextStyle(
    //   color: Colors.black,
    // ),
    labelSmall: TextStyle( //likes
      color: Colors.grey,
      letterSpacing: -0.2,
    ),
    labelLarge: TextStyle( //content
      letterSpacing: -0.2
    ),
    titleMedium: TextStyle( //Poster
      letterSpacing: -0.3
    )
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
    foregroundColor: Color.fromRGBO(59, 127, 210, 1),
  ),
  tabBarTheme: const TabBarTheme(
    unselectedLabelColor: Color.fromRGBO(121, 123, 125, 1),
    dividerColor: Color.fromRGBO(59, 127, 210, 1),
    labelColor: Color.fromRGBO(59, 127, 210, 1),
  )
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
    labelSmall: TextStyle( //likes
      color: Colors.grey,
      letterSpacing: -0.2,
    ),
    labelLarge: TextStyle( //content
      letterSpacing: -0.2
    ),
    titleMedium: TextStyle( //Poster
      letterSpacing: -0.3
    )
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 62, 58, 58),
    foregroundColor: Color.fromRGBO(255, 255, 255, 1),
  ),
  tabBarTheme: const TabBarTheme(
    unselectedLabelColor: Color.fromRGBO(121, 123, 125, 1),
    dividerColor: Color.fromRGBO(59, 127, 210, 1),
    labelColor: Color.fromRGBO(59, 127, 210, 1),
  )
);

class ThemeProvider with ChangeNotifier {
  var _theme = light;

  ThemeData get themeMode => _theme;

  dynamic toggleTheme(bool isDark) {
    _theme = isDark ? dark : light;
    notifyListeners();
  }
}