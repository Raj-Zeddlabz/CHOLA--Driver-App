import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String text;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.text,
  }) : super(key: key);
    /// Builds a widget that displays a custom button with an elevated button and an icon.
    ///
    /// The [BuildContext] used to access the screen dimensions.
    /// Returns an [Expanded] widget that contains a [Column] widget with an [ElevatedButton], a [SizedBox], and a [Text] widget.
    /// The [ElevatedButton] has a rounded rectangle border, transparent primary color, and an [Ink] widget as its child.
    /// The [Ink] widget has a linear gradient background, rounded rectangle border, and a [Padding] widget as its child.
    /// The [Padding] widget has horizontal and vertical padding based on the screen dimensions and an [Icon] widget as its child.
    /// The [Icon] widget has a size and color based on the screen dimensions.
    /// The [SizedBox] widget has a height based on the screen dimensions.
    /// The [Text] widget displays the provided [text].
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(0),
              backgroundColor: Colors.transparent,
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(217, 40, 180, 1),
                    Color.fromRGBO(67, 32, 219, 1)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                  vertical: MediaQuery.of(context).size.height * 0.015,
                ),
                child: Icon(
                  icon,
                  size: MediaQuery.of(context).size.width * 0.1,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(text),
        ],
      ),
    );
  }
}
