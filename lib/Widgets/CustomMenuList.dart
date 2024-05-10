import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const CustomListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
    // Builds the widget for this custom list tile.
  // 
  // The [BuildContext] parameter is the build context for this widget.
  // Returns a [ListTile] widget that contains an icon, title, and onTap action.
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.black,
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.shortestSide * 0.05,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}

class CustomListTile1 extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final double? fontsize;

  const CustomListTile1({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.fontsize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.height * 0.005,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double fontSize = fontsize ?? constraints.maxWidth * 0.075;
                  return Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
