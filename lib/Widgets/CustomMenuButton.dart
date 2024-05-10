// CustomMenuIconButton.dart

import 'package:chola_driver_flutter/Widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomMenuIconButton extends StatelessWidget {
  // final VoidCallback onPressed;
  final Widget? child_widget;

  const CustomMenuIconButton({
    Key? key,
    // required this.onPressed,
    this.child_widget, 
    // required onPressed,
  }) : super(key: key);

  @override
  // Builds the widget tree for the CustomMenuIconButton.
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      // => 
      // Get.drawer(SideMenu()), // Open the drawer

      icon: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.07,
        backgroundColor: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.016,
            vertical: MediaQuery.of(context).size.height * 0.017,
          ),
          child: child_widget,
        ),
      ),
    );
  }
}
