// // import 'package:chola_driver_flutter/Constants/Constants.dart';
// import 'package:flutter/material.dart';

// const lightColorScheme = ColorScheme(
//   brightness: Brightness.light,
//   primary: Color.fromARGB(234, 159, 128, 5),
//   onPrimary: Colors.black,
//   //Appbar color
//   primaryContainer: Color(0xFF839DFE),
//   onPrimaryContainer: Colors.black,
//   secondary: Color(0xffD3DBFB),
//   onSecondary: Color(0xFF000000),
//   //background Screen Color
//   background: Color(0xFFFFF8D7),
//   onBackground: Colors.black,
//   error: Colors.red,
//   onError: Color(0xff616161),
//   //Image Picker Colors
//   surface: Colors.white,
//   onSurface: Colors.black,
//   tertiary: Color(0xff1F2D60),
//   tertiaryContainer: Color(0xff6A4DE8),
// );
// // const darkColorScheme = ColorScheme(
// //   brightness: Brightness.dark,
// //   primary: Colors.white,
// //   onPrimary: Colors.black,
// //   //Appbar color
// //   primaryContainer: Color(0xFF839DFE),
// //   onPrimaryContainer: Colors.black,
// //   secondary: Color(0xFF839DFE),
// //   onSecondary: Color(0xFFFFFFFF),
// //   //Scaffold Color
// //   background: Colors.black,
// //   onBackground: Colors.white,
// //   error: Colors.red,
// //   onError: Colors.white,
// //   //Image Picker Colors
// //   surface: Colors.white,
// //   onSurface: Colors.black,
// // );

// const darkColorScheme = ColorScheme(
//   brightness: Brightness.dark,
//   primary: Color.fromARGB(255, 234, 159, 128),
//   onPrimary: Colors.black,
//   primaryContainer: Color(0xff6512E1),
//   onPrimaryContainer: Colors.white,
//   secondary: Color(0xFF1F1E2F),
//   onSecondary: Color(0xFFFFFFFF),
//   background: Color(0xFF1F1E2F),
//   onBackground: Colors.white,
//   error: Colors.red,
//   onError: Colors.white,
//   surface: Colors.white,
//   onSurface: Colors.black,
//   tertiary: Color(0xff8C2CE2),
//   tertiaryContainer: Color(0xff5004E0),
// );

import 'package:flutter/material.dart';
/*
  light: Defines a light theme with specific color scheme properties.
dark: Defines a dark theme with specific color scheme properties.
getSystemThemeData(BuildContext context): Returns the system theme data based on the brightness of the provided context, either light or dark.

*/
class ThemeDataStyle {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Color.fromARGB(234, 159, 128, 5),
      onPrimary: Colors.black,
      primaryContainer: Color(0xFF839DFE),
      onPrimaryContainer: Colors.black,
      secondary: Color(0xffD3DBFB),
      onSecondary: Color(0xFF000000),
      background: Color(0xFFFFF8D7),
      onBackground: Colors.black,
      error: Colors.red,
      onError: Color(0xff616161),
      surface: Colors.white,
      onSurface: Colors.black,
      tertiary: Color(0xff1F2D60),
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xff6A4DE8),
      onTertiaryContainer: Colors.black,
      secondaryContainer: Color(0xFFCED6FF),
    ),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Color.fromARGB(255, 234, 159, 128),
      onPrimary: Colors.black,
      primaryContainer: Color(0xff6512E1),
      onPrimaryContainer: Colors.white,
      secondary: Color(0xFF1F1E2F),
      onSecondary: Color(0xFFFFFFFF),
      background: Color(0xFF1F1E2F),
      onBackground: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
      tertiary: Color(0xff8C2CE2),
      onTertiary: Color(0xFF839DFE),
      tertiaryContainer: Color(0xff5004E0),
      onTertiaryContainer: Colors.black,
      secondaryContainer: Color.fromARGB(255, 142, 83, 232),
    ),
  );

  // Get the system theme data based on the brightness of the provided context.
  static ThemeData getSystemThemeData(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);
    return brightness == Brightness.dark
        ? ThemeDataStyle.dark
        : ThemeDataStyle.light;
  }
}
