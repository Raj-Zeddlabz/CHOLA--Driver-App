import 'package:chola_driver_flutter/Constants/colors_pallete.dart';
import 'package:chola_driver_flutter/Pages/ride_navigation/ride_navigation_screen.dart';
import 'package:chola_driver_flutter/Widgets/gradient_btn.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BottomSheetWidget extends StatefulWidget {
  final String title;
    final LatLng? passcurrentPosition;
  const BottomSheetWidget({super.key, required this.title, this.passcurrentPosition});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  late CountDownController _controller;
  

  bool _isLast10Seconds = false;

  @override
  void initState() {
    super.initState();
    _controller = CountDownController();
    _controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 560.h, 
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0), 
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child:
                        Container(color: ColorsPallete.bgcolor, height: 150.h),
                  ),
                  Center(
                    child: CircularCountDownTimer(
                        duration: 30,
                        initialDuration: 0,
                        controller: _controller,
                        width: 100.w,
                        height: 100.h,
                        ringColor: Colors.grey[100]!,
                        fillColor: _isLast10Seconds
                            ? const Color(0xFF0E9F14)
                            : Colors.red,
                        backgroundColor: Colors.white,
                        strokeWidth: 10.0,
                        strokeCap: StrokeCap.round,
                        textStyle: TextStyle(
                          fontSize: 45.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        textFormat: CountdownTextFormat.S,
                        isReverse: false,
                        isReverseAnimation: false,
                        isTimerTextShown: true,
                        autoStart: true,
                        onStart: () {
                          debugPrint('Countdown Started');
                        },
                        onChange: (String timeStamp) {
                          final int remainingSeconds = int.parse(timeStamp);
                          // Delay the call to setState() using addPostFrameCallback()
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              _isLast10Seconds = remainingSeconds <= 20;
                            });
                          });
                          debugPrint('Countdown Changed $timeStamp');
                        },
                        onComplete: () =>
                            Get.back() // Close bottom sheet on timer completion
                        ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 120.h,
                        ),
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'INR 1000.0',
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                color: ColorsPallete.mainbg,
                height: 350.h,
                child: Padding(
                  padding:
                      const EdgeInsets.all(20.0), // Adjust padding as needed
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: DottedLine(
                          dashColor: Color(0xFF2BDB3C),
                          lineLength: 70.h,
                          lineThickness: 2,
                          direction: Axis.vertical,
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 10.w,
                              ),
                              SizedBox(
                                height: 10.w,
                                width: 10.w,
                                child: const Icon(
                                  Icons.radio_button_checked,
                                  size: 30,
                                  color: Color(0xFFC5443C),
                                ),
                              ),
                              SizedBox(
                                width: 50.w,
                              ),
                              Text(
                                '4 Min',
                                style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                '(0.2km away)',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Text(
                            'Near raj path and metro station',
                            style: TextStyle(
                                fontSize: 17.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10.h),
                          DottedLine(
                            dashColor: Colors.black,
                            lineLength: 250.h,
                            lineThickness: 2,
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              SizedBox(
                                width: 10.w,
                              ),
                              SizedBox(
                                height: 10.w,
                                width: 10.w,
                                child: const Icon(
                                  Icons.location_on,
                                  size: 30,
                                  color: Color(0xFF2BDB3C),
                                ),
                              ),
                              SizedBox(
                                width: 50.w,
                              ),
                              Text(
                                '1 hours trip',
                                style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                '(7.2km away)',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 70.w,
                              ),
                              Text(
                                'Near Hanuman mandir',
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 25.h),
                          Center(
                            child: Column(
                              children: [
                                GradientBtn(
                                    onPressed: () {
                                     setState(() {
                                        Get.to(() => RideNavigationScreen(
                                              passcurrentPosition:
                                                  widget.passcurrentPosition,
                                            ));
                                      });
                                    },
                                    textbtn: 'Accept',
                                    color1: ColorsPallete.btngradient2,
                                    color2: ColorsPallete.btngradient1),
                                SizedBox(
                                  height: 10.h,
                                ),
                                GradientBtn(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    textbtn: 'Decline',
                                    color1: ColorsPallete.btngradient4,
                                    color2: ColorsPallete.btngradient3),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}





















// class BottomSheetWidget extends StatelessWidget {
//   final String title;
//   // final Widget child;

//   const BottomSheetWidget({
//     super.key,
//     required this.title,
//     // required this.child,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 480.h, // Adjust height as needed
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         // crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Stack(
//             children: [
//               Container(color: ColorsPallete.bgcolor, height: 170.h),
//               Center(
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 70.h,
//                     ),
//                     Text(
//                       title,
//                       style: TextStyle(
//                           fontSize: 25.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                     SizedBox(
//                       height: 5.h,
//                     ),
//                     Text(
//                       'INR 1000.0',
//                       style: TextStyle(
//                         fontSize: 25.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20.0), // Adjust padding as needed
//             child: Stack(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(24.0),
//                   child: DottedLine(
//                     dashColor: Color(0xFF2BDB3C),
//                     lineLength: 70.h,
//                     lineThickness: 2,
//                     direction: Axis.vertical,
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: 10.w,
//                         ),
//                         SizedBox(
//                           height: 10.w,
//                           width: 10.w,
//                           child: const Icon(
//                             Icons.radio_button_checked,
//                             size: 30,
//                             color: Color(0xFFC5443C),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 50.w,
//                         ),
//                         Text(
//                           '4 Min',
//                           style: TextStyle(
//                               fontSize: 25.sp,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black),
//                         ),
//                         SizedBox(
//                           width: 10.w,
//                         ),
//                         Text(
//                           '(0.2km away)',
//                           style: TextStyle(
//                               fontSize: 15.sp,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black),
//                         ),
//                       ],
//                     ),
//                     Text(
//                       'Near raj path and metro station',
//                       style: TextStyle(
//                           fontSize: 17.sp, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 10.h),
//                     DottedLine(
//                       dashColor: Colors.black,
//                       lineLength: 250.h,
//                       lineThickness: 2,
//                     ),
//                     SizedBox(height: 10.h),
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: 10.w,
//                         ),
//                         SizedBox(
//                           height: 10.w,
//                           width: 10.w,
//                           child: const Icon(
//                             Icons.location_on,
//                             size: 30,
//                             color: Color(0xFF2BDB3C),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 50.w,
//                         ),
//                         Text(
//                           '1 hours trip',
//                           style: TextStyle(
//                               fontSize: 25.sp,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black),
//                         ),
//                         SizedBox(
//                           width: 10.w,
//                         ),
//                         Text(
//                           '(7.2km away)',
//                           style: TextStyle(
//                               fontSize: 15.sp,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: 70.w,
//                         ),
//                         Text(
//                           'Near Hanuman mandir',
//                           style: TextStyle(
//                               fontSize: 17.sp, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 25.h),
//                     Center(
//                       child: Column(
//                         children: [
//                           GradientBtn(
//                               onPressed: () {
//                                 Get.to(RideNavigationScreen());
//                               },
//                               textbtn: 'Accept',
//                               color1: ColorsPallete.btngradient2,
//                               color2: ColorsPallete.btngradient1),
//                           SizedBox(
//                             height: 10.h,
//                           ),
//                           GradientBtn(
//                               onPressed: () {
//                                 Get.back();
//                               },
//                               textbtn: 'Decline',
//                               color1: ColorsPallete.btngradient4,
//                               color2: ColorsPallete.btngradient3),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
