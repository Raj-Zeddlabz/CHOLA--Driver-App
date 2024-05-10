import 'package:flutter/material.dart';

class AdCardWidget extends StatefulWidget {
  final List<String> ads;

  AdCardWidget({required this.ads});

  @override
  _AdCardWidgetState createState() => _AdCardWidgetState();
}

class _AdCardWidgetState extends State<AdCardWidget> {
  int currentAdIndex = 0;

  @override
  void initState() {
    super.initState();
    startAdTimer();
  }
  /// Starts an ad timer that cycles through a list of ads.
  ///
  /// This function initializes a timer that delays the execution of the code by
  /// 5 seconds. After the delay, it checks if the list of ads is not empty. If
  /// the list is not empty, it increments the `currentAdIndex` by 1 and takes
  /// the modulo of the length of the ads list. It then checks if the widget is
  /// mounted and if so, it calls `setState` to update the UI. Finally, it
  /// recursively calls `startAdTimer` to continue the cycle of ads.
  ///
  /// This function does not take any parameters and does not return any value.
  void startAdTimer() {
    Future.delayed(Duration(seconds: 5), () {
      if (widget.ads.isNotEmpty) {
        currentAdIndex = (currentAdIndex + 1) % widget.ads.length;
        if (mounted) {
          setState(() {});
        }
        startAdTimer();
      }
    });
  }

  @override
    /// Builds a widget that displays an ad card with an animated image and a set of dots indicating the current ad index.
  ///
  /// The [BuildContext] used to access the screen dimensions.
  /// Returns a [Container] widget that contains a [Column] widget with a [Card] widget and an [Expanded] widget.
  /// The [Card] widget contains a [ClipRRect] widget with an [AnimatedSwitcher] widget.
  /// The [AnimatedSwitcher] widget displays the current ad image.
  /// The [Expanded] widget contains a [Row] widget with a set of [Container] widgets representing the ad dots.
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        children: [
          Card(
            semanticContainer: true,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 1000),
                child: _buildAdImage(),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.03),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.ads.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.005),
                  width: MediaQuery.of(context).size.width * 0.02,
                  height: MediaQuery.of(context).size.width * 0.02,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == currentAdIndex ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  // Function to build the ad image widget, handles loading the image and errors with fallback images.
  Widget _buildAdImage() {
    try {
      return Image.network(
        isAntiAlias: true,
        widget.ads[currentAdIndex],
        key: ValueKey<int>(currentAdIndex),
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) {
          // Handle error loading image
          print('Error loading ad image: $error');
          return Image.asset(
            height: MediaQuery.of(context).size.height * 0.2,
            'assets/Internet_error.png',
            fit: BoxFit.fill,
          ); // Fallback image
        },
      );
    } catch (error) {
      // Handle general error
      print('Error: $error');
      return Image.asset(
        height: MediaQuery.of(context).size.height * 0.2,
        'assets/Recent.png',
        fit: BoxFit.fill,
      ); // Fallback image
    }
  }
}
