import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  final String buttontext;
  final String imagePath;
  const SocialMediaButton({
    required this.buttontext,
    required this.imagePath,
    super.key,
  });

  /// Builds the widget tree for this widget based on the given [BuildContext].
  ///
  /// The [context] parameter is the build context for this widget.
  ///
  /// Returns the widget tree for this widget.
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Ink(
          child: Image.asset(imagePath
              // 'assets/facebook.png',
              ),
        ),
        FittedBox(
          child: Text(
            buttontext,
            // 'Facebook',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: size.shortestSide * 0.035,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
