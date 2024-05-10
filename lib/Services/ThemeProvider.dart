import 'package:chola_driver_flutter/Constants/Colors.dart';
import 'package:flutter/material.dart';
/*
  The ThemeProvider class is a part of the Flutter framework and is used to manage the theme of an application. It extends the ChangeNotifier class, which allows it to notify listeners when the theme changes.

Here's a succinct explanation of each method in the ThemeProvider class:

ThemeData get themeDataStyle: This getter method returns the current theme data style.
set themeDataStyle(ThemeData themeData): This setter method sets the theme data style and notifies listeners of the change.
void changeTheme(): This method changes the theme of the application between light and dark mode. It checks the current theme and toggles it to the opposite mode. If the current theme is light mode, it sets the theme to dark mode. If the current theme is dark mode, it sets the theme to light mode.
Overall, the ThemeProvider class provides a convenient way to manage and switch between different themes in a Flutter application.
 */
class ThemeProvider extends ChangeNotifier {

  ThemeData _themeDataStyle = ThemeDataStyle.light;

  ThemeData get themeDataStyle => _themeDataStyle;

  set themeDataStyle (ThemeData themeData) {
   _themeDataStyle = themeData;
   notifyListeners();
  }
    /**
     * Changes the theme of the application between light and dark mode.
     *
     * This function checks the current theme and toggles it to the opposite mode.
     * If the current theme is light mode, it sets the theme to dark mode.
     * If the current theme is dark mode, it sets the theme to light mode.
     */
  void changeTheme() {
    if (_themeDataStyle == ThemeDataStyle.light) {
      themeDataStyle = ThemeDataStyle.dark;
    } else {
      themeDataStyle = ThemeDataStyle.light;
    }
  }
  
}