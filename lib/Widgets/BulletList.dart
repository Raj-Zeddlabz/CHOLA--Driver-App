import 'package:flutter/material.dart';

class BulletList extends StatelessWidget {
  final List<String> items;

  const BulletList({Key? key, required this.items}) : super(key: key);

  @override
      /// Builds a widget that displays a list of items with a bullet icon and text.
    ///
    /// The [BuildContext] used to access the screen dimensions.
    /// Returns a [Column] widget containing a list of [ListTile] widgets.
    /// Each [ListTile] widget has a leading [Image] widget displaying a bullet icon,
    /// and a title [Text] widget displaying the item text.
    /// The item text color is black, the font size is 2.5% of the screen height,
    /// the font family is 'Poppins', the font weight is w600, and the height is 0.
    ///
    /// The [items] parameter is a list of strings representing the items to be displayed.
    ///
    /// Returns a [Widget] representing the built column of list tiles.
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: items
          .map((item) => ListTile(
                leading: Image.asset(
                  'assets/bullet_icon.png',
                ),
                title: Text(
                  item,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ))
          .toList(),
    );
  }
}
