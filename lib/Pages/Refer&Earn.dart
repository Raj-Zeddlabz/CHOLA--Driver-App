import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/ComingSoon.dart';
import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
import 'package:chola_driver_flutter/Widgets/SocialMediaButton.dart';
import 'package:flutter/material.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';

class ReferAndEarn extends StatefulWidget {
  const ReferAndEarn({super.key});

  @override
  State<ReferAndEarn> createState() => _ReferAndEarnState();
}

class _ReferAndEarnState extends State<ReferAndEarn> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(
        top: statusBarHeight,
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          preferredHeight: size.height * 0.09,
          title: "Refer and Earn",
        ),
        body: SizedBox(
          height: size.height - statusBarHeight,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04,
              vertical: MediaQuery.of(context).size.height * 0.03,
            ),
            color: Theme.of(context).colorScheme.background,
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //   ),
            // ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Text(
                    '${Constants.firstName}, Get 20% off on your next ride',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: size.shortestSide * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  DottedDashedLine(
                    height: 0,
                    width: double.infinity,
                    axis: Axis.horizontal,
                    dashColor: Theme.of(context).colorScheme.onBackground,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Text(
                    'Use the link below to refer a friend to sign up !\nWe\'ll reward you with 20% off your next ride.\nYour friend will get a 20% off on  their first ride.',
                    overflow: TextOverflow.clip,
                    maxLines: null,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: size.shortestSide * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  DottedDashedLine(
                    height: 0,
                    width: double.infinity,
                    axis: Axis.horizontal,
                    dashColor: Theme.of(context).colorScheme.onBackground,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SocialMediaButton(
                        imagePath: 'assets/facebook.png',
                        buttontext: 'Facebook',
                      ),
                      SocialMediaButton(
                        imagePath: 'assets/WhatsApp.png',
                        buttontext: 'WhatsApp',
                      ),
                      SocialMediaButton(
                        imagePath: 'assets/Twitter.png',
                        buttontext: 'Twitter',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SocialMediaButton(
                        imagePath: 'assets/Telegram.png',
                        buttontext: 'Telegram',
                      ),
                      SocialMediaButton(
                        imagePath: 'assets/LinkedIn.png',
                        buttontext: 'LinkedIn',
                      ),
                      SocialMediaButton(
                        imagePath: 'assets/Email.png',
                        buttontext: 'Email',
                      ),
                    ],
                  ),

                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Container(
                    // color: Color(0xffCFD4FE),
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.02,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black),
                      color: Color(0xffCFD4FE),
                    ),
                    child: Text(
                      'https://cholareferral-factory.com',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: size.shortestSide * 0.04,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  AgreeButton(
                    buttonText: "Share Link",
                    onPressed: () {
                      // Share.share('https://cholareferral-factory.com');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ComingSoon(),
                      //   ),
                      // );
                      Constants.showError(context,
                          "Stay Tuned for an Exciting Addition! We're thrilled to announce a new feature coming your way!");
                    },
                    padding: 0.6,
                  ),

                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Ink(
                  //       child: Image.asset(
                  //         'assets/facebook.png',
                  //       ),
                  //     ),
                  //     Text(
                  //       'Facebook',
                  //       overflow: TextOverflow.ellipsis,
                  //       maxLines: 1,
                  //       style: TextStyle(
                  //         color: Theme.of(context).colorScheme.onBackground,
                  //         fontSize: size.shortestSide * 0.04,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
