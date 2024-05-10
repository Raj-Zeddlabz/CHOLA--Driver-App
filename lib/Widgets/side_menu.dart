import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SideMenu extends GetxController {
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Row(
              children: [
                Text(
                  'Chola',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Drive with Chola'),
            leading: Icon(Icons.directions_car),
            onTap: () => Get.back(), // Close the drawer on tap
          ),
          ListTile(
            title: Text('Own a Chariot'),
            leading: Icon(Icons.shopping_cart),
            onTap: () => Get.back(), // Close the drawer on tap
          ),
          // Add more menu items here
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.logout),
            onTap: () => Get.back(), // Close the drawer on tap
          ),
        ],
      ),
    );
  }
}
