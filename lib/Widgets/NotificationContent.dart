import 'dart:async';
import 'dart:math';

import 'package:chola_driver_flutter/Pages/Earning.dart';
import 'package:chola_driver_flutter/Pages/HomePage.dart';
import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/src/font_awesome_icon_class.dart';

class NotificationContent extends StatefulWidget {
  final String title;
  final String? body;
  final VoidCallback onDecline;
  final VoidCallback onAccept;

  NotificationContent({
    required this.title,
    this.body,
    required this.onDecline,
    required this.onAccept,
  });

  @override
  _NotificationContentState createState() => _NotificationContentState();
}

class _NotificationContentState extends State<NotificationContent> {
  double _percentage = 1.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  /// Starts a timer that periodically updates the `_percentage` variable and cancels the timer when it reaches zero.
  ///
  /// This function initializes a timer that delays the execution of the code by 1 second.
  /// After the delay, it checks if the `_percentage` variable is not less than or equal to zero.
  /// If it is, the timer is canceled and the `onDecline` callback is called.
  /// Otherwise, the `_percentage` variable is decremented by 0.055 and the UI is updated using the `setState` method.

  void startTimer() {
    const duration = Duration(seconds: 1);
    _timer = Timer.periodic(duration, (Timer timer) {
      if (_percentage <= 0) {
        timer.cancel();
        widget.onDecline();
      } else {
        setState(() {
          _percentage -= 0.055;
        });
      }
    });
  }

  @override
  // Builds the UI for the notification content dialog. It displays information about a ride,
  //including ride details and actions to accept or decline the ride.
  //The UI consists of various widgets
  // like Text, ListTile, DottedDashedLine, AgreeButton, and CustomPaint for showing a timer.
  // The function returns a Material widget wrapped inside a WillPopScope and a Stack
  //to manage the UI components' layout and interaction.
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: size.height * .15,
                    color: Color(0xFF2E50CE),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              'Solo Ride',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Roboto Flex',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * .015,
                          ),
                          Flexible(
                            child: Text(
                              'INR 1000.00',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Roboto Flex',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.locationCrosshairs,
                        color: Colors.red,
                      ),
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '4 Min ',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: 20,
                                fontFamily: 'Roboto Flex',
                                fontWeight: FontWeight.w700,
                                height:
                                    1, // Adjusted the height to 1 for normal spacing
                              ),
                            ),
                            TextSpan(
                              text: '(0.2 km away)',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: 14,
                                fontFamily: 'Roboto Flex',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      subtitle: Text(
                        'Near raj path and metro station',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 14,
                          fontFamily: 'Roboto Flex',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * .15,
                    ),
                    child: DottedDashedLine(
                      height: 0,
                      width: size.width,
                      axis: Axis.horizontal,
                      dashColor: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.locationDot,
                        color: Colors.green,
                      ),
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '1 hours trip ',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: 20,
                                fontFamily: 'Roboto Flex',
                                fontWeight: FontWeight.w700,
                                height:
                                    1, // Adjusted the height to 1 for normal spacing
                              ),
                            ),
                            TextSpan(
                              text: '(7.2km away)',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: 14,
                                fontFamily: 'Roboto Flex',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      subtitle: Text(
                        'Near Hanuman mandir',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 14,
                          fontFamily: 'Roboto Flex',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * .09,
                      vertical: size.height * .01,
                    ),
                    child: AgreeButton(
                      buttonText: "Accept",
                      onPressed: widget.onAccept,
                      padding: 0.7,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * .09,
                      vertical: size.height * .01,
                    ),
                    child: AgreeButton(
                      buttonText: "Decline",
                      fillColor: [Color(0xFFC31010), Color(0xFFF66A6A)],
                      onPressed: widget.onDecline,
                      padding: 0.7,
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                left: MediaQuery.of(context).size.width / 2,
                child: Transform.translate(
                  offset: Offset(-50, -60),
                  child: SizedBox(
                    width: size.width / 8,
                    child: CustomPaint(
                      painter: TimerPainter(
                        percentage: _percentage,
                        color: Color(0xff0E9F14),
                        strokeWidth: 8,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class TimerPainter extends CustomPainter {
  final double percentage;
  final Color color;
  final double strokeWidth;

  TimerPainter({
    required this.percentage,
    required this.color,
    required this.strokeWidth,
  });

  @override

  /// Paints a timer circle on the given `canvas` with the specified `size`.
  ///
  /// The timer circle is drawn as a filled circle with a white color. The filled
  /// portion of the circle is determined by the `percentage` parameter. The
  /// color of the filled portion is determined by the `color` parameter. The
  /// stroke width of the circle is determined by the `strokeWidth` parameter.
  ///
  /// The timer circle is drawn at the center of the `canvas` with a radius equal
  /// to half of the `size` parameter.
  ///
  /// A text label is also drawn on the timer circle. The text label displays the
  /// remaining time in seconds based on the `percentage` parameter. The font
  /// size of the text label is determined by the radius of the timer circle
  /// multiplied by 0.5. The font weight of the text label is bold.
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    double radius = size.width;
    Offset center = Offset(radius, radius);

    paint.color = Colors.white;
    canvas.drawCircle(center, radius, paint);

    // Draw filled circle with white color
    paint.color = percentage >= 0 ? color : Colors.white;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // start angle
      2 * pi * percentage, // sweep angle
      true,
      paint,
    );

    TextSpan span = TextSpan(
      style: TextStyle(
        color: Colors.black, // don't change this
        fontSize: radius * 0.5,
        fontWeight: FontWeight.bold,
      ),
      text:
          '${(percentage * 20).ceil()}', // Assuming the timer is for 20 seconds
    );
    TextPainter tp = TextPainter(
      strutStyle: StrutStyle(
        fontFamily: "Roboto",
        fontSize: radius * 0.3,
      ),
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    Offset textOffset =
        Offset(center.dx - tp.width / 2, center.dy - tp.height / 2);
    tp.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
