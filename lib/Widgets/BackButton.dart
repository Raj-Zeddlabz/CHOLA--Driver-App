import 'package:flutter/material.dart';

class BackButton1 extends StatelessWidget {
  final VoidCallback? onPressed;
  const BackButton1({Key? key, this.onPressed}) : super(key: key);

  @override
    // Builds the widget for the Back Button with a GestureDetector that pops the current route when tapped.
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ??
          () {
            Navigator.of(context).pop();
          },
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.015,
          bottom: MediaQuery.of(context).size.width * 0.01,
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              )),
          child: Image.asset(
            'assets/BackButton.png',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
