import '../index.dart';

const Color whitee = Color.fromARGB(255, 255, 255, 255);
const Color blue = Color.fromRGBO(59, 127, 210, 1);
const Color lightdark = Color.fromARGB(255, 38, 38, 38);

ThemeData light = ThemeData(
  fontFamily: 'HyWenHei',
  // brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromARGB(235, 255, 255, 255),
  textTheme: const TextTheme(
      titleLarge: TextStyle(
        //feed name
        letterSpacing: -1.0,
        color: Colors.black,
      ),
      labelSmall: TextStyle(
        //likes
        color: Colors.grey,
        letterSpacing: -0.2,
      ),
      labelLarge: TextStyle(
          //setting list view text
          //content
          color: Colors.black,
          letterSpacing: -0.8),
      titleMedium: TextStyle(
          //Poster
          //user name in user profile
          letterSpacing: -1.0),
      bodySmall: TextStyle(
        color: Color.fromARGB(255, 49, 48, 48),
        letterSpacing: -0.2,
      ),
      bodyMedium: TextStyle(
        color: Color.fromARGB(255, 49, 48, 48),
        letterSpacing: -0.8,
      ),
      headlineSmall: TextStyle(
          //setting friend view text
          //content
          color: Colors.black,
          letterSpacing: -0.8)),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
    foregroundColor: Color.fromRGBO(0, 0, 0, 1),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    unselectedLabelColor: Color.fromRGBO(121, 123, 125, 1),
    dividerColor: Palette.facebookBlue,
    labelColor: Palette.facebookBlue,
  ),
  filledButtonTheme: const FilledButtonThemeData(
      style: ButtonStyle(
          splashFactory: InkSplash.splashFactory,
          overlayColor:
              MaterialStatePropertyAll(Color.fromARGB(255, 187, 189, 196)),
          backgroundColor:
              MaterialStatePropertyAll(Color.fromARGB(255, 228, 230, 235)))),
  inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
      fillColor: Color.fromARGB(255, 240, 242, 245),
      hintStyle: TextStyle(
          color: Color.fromARGB(255, 143, 146, 150),
          letterSpacing: -0.2,
          fontSize: 12,
          fontStyle: FontStyle.normal)),
  listTileTheme: const ListTileThemeData(textColor: Colors.black),
  popupMenuTheme: PopupMenuThemeData(
    color: const Color.fromARGB(255, 255, 255, 255),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), side: BorderSide.none),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
  dividerTheme: DividerThemeData(color: Color.fromARGB(255, 207, 208, 209)),
  // colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
);

ThemeData dark = ThemeData(
  fontFamily: 'HyWenHei',
  // brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color.fromARGB(235, 0, 0, 0),
  // colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(161, 158, 158, 158)),
  textTheme: const TextTheme(
      // bodySmall: TextStyle(
      //   color: Colors.grey,
      // ),
      // labelMedium: TextStyle(
      //   color: Colors.black,
      // ),

      titleLarge: TextStyle(
        //feed name
        letterSpacing: -1.0,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        //likes
        color: Colors.grey,
        letterSpacing: -0.2,
      ),
      labelLarge: TextStyle(
          //content
          color: Color.fromRGBO(255, 255, 255, 1),
          letterSpacing: -0.8),
      titleMedium: TextStyle(
          //Poster
          color: Color.fromRGBO(255, 255, 255, 1),
          letterSpacing: -1.0),
      bodySmall: TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        letterSpacing: -0.2,
      ),
      bodyMedium: TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        letterSpacing: -0.8,
      ),
      headlineSmall: TextStyle(
          //setting friend view text
          //content
          color: Color.fromRGBO(255, 255, 255, 1),
          letterSpacing: -0.8)),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 38, 38, 38),
    foregroundColor: Color.fromRGBO(255, 255, 255, 1),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    unselectedLabelColor: Color.fromRGBO(121, 123, 125, 1),
    dividerColor: Palette.facebookBlue,
    labelColor: Palette.facebookBlue,
  ),
  filledButtonTheme: const FilledButtonThemeData(
      style: ButtonStyle(
          splashFactory: InkSplash.splashFactory,
          overlayColor:
              MaterialStatePropertyAll(Color.fromARGB(255, 97, 97, 97)),
          backgroundColor:
              MaterialStatePropertyAll(Color.fromARGB(255, 58, 59, 60)))),
  // iconTheme: IconThemeData(color: const Color.fromARGB(255, 176, 179, 184)),
  // listTileTheme: ListTileThemeData(
  //     leadingAndTrailingTextStyle:
  //         TextStyle(color: const Color.fromARGB(255, 176, 179, 184)),
  //     contentPadding: EdgeInsets.all(4),
  //     style: ListTileStyle.list),
  inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
      fillColor: Color.fromARGB(255, 58, 59, 60),
      hintStyle: TextStyle(
          color: Color.fromARGB(255, 143, 146, 150),
          letterSpacing: -0.2,
          fontSize: 12,
          fontStyle: FontStyle.normal)),
  listTileTheme: const ListTileThemeData(textColor: Colors.white),
  popupMenuTheme: PopupMenuThemeData(
    color: const Color.fromARGB(255, 59, 56, 56),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), side: BorderSide.none),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(color: lightdark),
  dividerTheme: DividerThemeData(color: Color.fromARGB(255, 94, 95, 98)),
  // colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
);

class ThemeProvider with ChangeNotifier {
  var _theme = light;

  ThemeData get themeMode => _theme;

  dynamic toggleTheme(bool isDark) {
    _theme = isDark ? dark : light;
    notifyListeners();
  }
}
