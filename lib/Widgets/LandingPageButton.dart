import 'package:flutter/material.dart';

class LandingPageButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double padding;
  final double fontsize;

  const LandingPageButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    required this.padding,
    required this.fontsize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * padding,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff1F2D60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          buttonText,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * fontsize,
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
