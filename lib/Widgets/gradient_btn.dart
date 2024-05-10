import 'package:chola_driver_flutter/Constants/colors_pallete.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientBtn extends StatelessWidget {
  final String textbtn;
  final Color color1;
  final Color color2;
  final VoidCallback onPressed;

  const GradientBtn(
      {super.key,
      required this.textbtn,
      required this.color1,
      required this.color2,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color1,
              color2,
            ],
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: FilledButton(
        onPressed: onPressed,
        child: Text(
          textbtn,
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 25.sp,
              color: Colors.white),
        ),
        style: FilledButton.styleFrom(
          backgroundColor: ColorsPallete.transparentColor,
          shadowColor: ColorsPallete.transparentColor,
          minimumSize: Size(300.w, 50.h), // Adjust button size as needed
          // primary: Colors.green,
        ),
      ),
    );
  }
}
