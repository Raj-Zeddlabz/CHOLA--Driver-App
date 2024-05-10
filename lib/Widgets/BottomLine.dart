import 'package:flutter/material.dart';

class bottomLine extends StatelessWidget {
  const bottomLine({
    super.key,
  });

  @override
    /// Builds the widget tree for this widget.
  ///
  /// The [context] parameter is the build context for this widget.
  ///
  /// Returns the widget tree for this widget.
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        double fontSize = constraints.maxWidth * 0.04;
        return Text.rich(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          TextSpan(
            children: [
              TextSpan(
                text:
                    'Upload these documents to become a Driving Partner with ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: fontSize,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              TextSpan(
                text: 'CHOLA',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
