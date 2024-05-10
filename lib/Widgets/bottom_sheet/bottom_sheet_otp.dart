import 'package:chola_driver_flutter/Constants/colors_pallete.dart';
// import 'package:chola_driver_flutter/Pages/auth_Login_screen/otp_screen.dart';
import 'package:chola_driver_flutter/Widgets/gradient_btn.dart';
import 'package:chola_driver_flutter/Widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';

class BottomSheetOTP extends StatefulWidget {
  const BottomSheetOTP({super.key});

  @override
  State<BottomSheetOTP> createState() => _BottomSheetOTPState();
}

class _BottomSheetOTPState extends State<BottomSheetOTP> {
  final _emailFormKey = GlobalKey<FormState>();

  TextEditingController _otpController = TextEditingController();

  bool _showResendButton = false;

  // final _emailFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final defaultPinTheme = PinTheme(
      width: size.width * 0.2,
      height: size.height * 0.07,
      textStyle: TextStyle(
          fontSize: size.shortestSide * 0.06,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: Color(0xFF839DFE),
      ),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color(0xFF839DFE),
      ),
    );
    return Container(
      height: 400.h,
      child: Form(
        key: _emailFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Pinput(
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                length: 6,
                autofocus: true,
                isCursorAnimationEnabled: true,
                controller: _otpController,
                onCompleted: (value) async {},
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            GradientBtn(
                onPressed: () async {
                  await Future.delayed(Duration(seconds: 2));
                  String otp = _otpController.text.toString();
                  if (otp == "777777") {
                    // Get.back();
                    CustomSnackbar.showSuccess(
                      "Yey! You have earned INR 1000.00.from this ride",
                      "Amount Is Credited To Your Bank Account",
                    );
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Incorrect OTP!",
                          semanticsLabel: "Phone number verification failed!"),
                    ));
                  }
                },
                textbtn: 'CONFIRM',
                color1: ColorsPallete.btngradient2,
                color2: ColorsPallete.btngradient1),
            SizedBox(
              height: size.height * 0.01,
            ),
          ],
        ),
      ), // Adjust height as needed
    );
  }
}
