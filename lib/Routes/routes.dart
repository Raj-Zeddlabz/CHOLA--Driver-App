import 'package:chola_driver_flutter/Widgets/Menu.dart';
import 'package:chola_driver_flutter/Widgets/NotificationContent.dart';
import 'package:chola_driver_flutter/Widgets/bottom_nav_bar.dart';
import 'package:get/get.dart';

class RoutesHelper {
  static const String loginScreen = "/login";
  static const String bottomnavbar = "/bottom-nav-bar";

  static const String appbarnotification = "/appbar-notification";
  static const String sidemenu = "/appbar-sidemenu";

  static String getbottomnavbar() => bottomnavbar;

  static String getappbarnotification() => appbarnotification;
  static String getsidemenu() => sidemenu;

  static List<GetPage> routes = [
    GetPage(
      name: bottomnavbar,
      page: () => const BottomNavbar(),
      transition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    // GetPage(
    //   name: appbarnotification,
    //   // page: () => NotificationContent(),
    //   transition: Transition.zoom,
    //   transitionDuration: const Duration(milliseconds: 500),
    // ),
    GetPage(
      name: sidemenu,
      page: () => MenuWidget(),
      transition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
