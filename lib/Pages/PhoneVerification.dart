import 'dart:async';
import 'dart:convert';
import 'package:chola_driver_flutter/Constants/ApiCollection.dart';
import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/HomePage.dart';
import 'package:chola_driver_flutter/Pages/LoginPage2.dart';
// import 'package:chola_driver_flutter/Pages/Verifying.dart';
import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class PhoneVerify extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  final bool alreadyExist;
  final String jwt;
  PhoneVerify({
    Key? key,
    required this.phoneNumber,
    required this.alreadyExist,
    required this.jwt,
    required this.verificationId,
  }) : super(key: key);

  @override
  State<PhoneVerify> createState() => _PhoneVerifyState();
}

class _PhoneVerifyState extends State<PhoneVerify> {
  Timer? _resendTimer;
  int _resendSeconds = 30;
  TextEditingController _otpController = TextEditingController();
  bool _showResendButton = false;
  final _emailFormKey = GlobalKey<FormState>();

  Map<String, dynamic> data = {};

  @override

  // verifyPhoneNumber() async {
  //   print('dhjbcjdkbcdkj');
  //   // print(dialCode.runtimeType);
  //   var response = await http.put(
  //     Uri.parse('https://chola-web-app.azurewebsites.net/api/auth/update'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${widget.jwt}',
  //     },
  //     body: jsonEncode({
  //       'phoneNoVerified': true,
  //     }),
  //   );
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     print(json.decode(response.body).runtimeType);
  //     return json.decode(response.body);
  //   } else {
  //     throw Exception('Failed to verify PhoneNumber.');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    startResendTimer();
  }

  @override
  void dispose() {
    _resendTimer!.cancel();
    super.dispose();
  }
    /// Starts a timer that periodically updates the `_resendSeconds` variable and cancels the timer when it reaches zero.
    ///
    /// This function does not take any parameters.
    ///
    /// This function does not return any values.
  void startResendTimer() {
    _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_resendSeconds > 0) {
        setState(() {
          _resendSeconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          _showResendButton = true;
        });
      }
    });
  }
    /// Resends the OTP (One-Time Password) for verification.
    ///
    /// This function sets the `_resendSeconds` variable to 30 and hides the resend button.
    /// It then starts a timer that periodically updates the `_resendSeconds` variable and cancels the timer when it reaches zero.
    ///
    /// This function does not take any parameters.
    ///
    /// This function does not return any values.
  void resendOTP() {
    // Resend OTP logic
    setState(() {
      _resendSeconds = 30;
      _showResendButton = false;
    });
    startResendTimer();
  }

  @override
    /// Builds the widget tree for the phone verification page.
  ///
  /// This function takes a `BuildContext` as a parameter and returns a `Widget`.
  ///
  /// The function retrieves the size of the media query and calculates the height of the status bar.
  /// It then creates three `PinTheme` objects with different properties.
  ///
  /// The function creates a `SingleChildScrollView` widget that contains a `SizedBox` with a height equal to the height of the media query minus the status bar height.
  /// Inside the `SizedBox`, there is a `Form` widget that contains several other widgets such as `Text`, `Container`, and `TextButton`.
  /// The `Form` widget has a key `_emailFormKey` and contains a `Column` widget with several children.
  ///
  /// The `Column` widget contains a `Text` widget that displays the phone number and a `Container` widget that contains a `Pinput` widget for entering the OTP code.
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    final defaultPinTheme = PinTheme(
      width: size.width * 0.2,
      height: size.height * 0.07,
      textStyle: TextStyle(
          fontSize: size.shortestSide * 0.06,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onBackground,
        ),
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
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Padding(
      padding: EdgeInsets.only(
        top: statusBarHeight,
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Phone OTP",
          preferredHeight: MediaQuery.of(context).size.height * 0.08,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: SizedBox(
            height: size.height - statusBarHeight,
            child: Form(
              key: _emailFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Text(
                    "Enter the 6-digit code sent to \n" + widget.phoneNumber,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
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
                      onCompleted: (value) async {
                        try {
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: _otpController.text.toString(),
                          );
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithCredential(credential);
                          if (userCredential.user != null) {
                            Map<String, dynamic> result =
                                await ApiCollection.verifyPhoneNumber();
                            setState(() {
                              data = result;
                              Constants.user_data = result;
                              Constants.phoneNo =
                                  result['user']['countryCode'].toString() +
                                      '-' +
                                      result['user']['phoneNo'].toString();
                            });
                            print("6474561");
                            print(Constants.user_data);
                            print(Constants.user_data['user']['phoneNo']);
                            print("123456");
                            print(Constants.phoneNo);
                            (widget.alreadyExist)
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                  )
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage2(
                                        jwt: data['jwt'] as String,
                                        // jwt: "",
                                      ),
                                    ),
                                  );
                          }
                        } catch (e) {
                          print('Exception: $e');
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  AgreeButton(
                    buttonText: "Confirm",
                    onPressed: () async {
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: _otpController.text.toString(),
                        );
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithCredential(credential);
                        if (userCredential.user != null) {
                          Map<String, dynamic> result =
                              await ApiCollection.verifyPhoneNumber();
                          setState(() {
                            data = result;
                            Constants.user_data = result;
                            Constants.phoneNo =
                                result['user']['countryCode'].toString() +
                                    '-' +
                                    result['user']['phoneNo'].toString();
                          });
                          print("6474561");
                          print(Constants.user_data);
                          print(Constants.user_data['user']['phoneNo']);
                          print("123456");
                          print(Constants.phoneNo);
                          (widget.alreadyExist)
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                )
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage2(
                                      jwt: data['jwt'] as String
                                      // jwt: "",
                                    ),
                                  ),
                                );
                        }
                      } catch (e) {
                        print('Exception: $e');
                      }
                    },
                    padding: 0.7,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  _showResendButton
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.04,
                            ),
                            child: TextButton(
                              onPressed: resendOTP,
                              child: Text(
                                "Resend OTP",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: size.shortestSide * 0.04,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              // padding: 0.6,
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.04,
                            ),
                            child: Text(
                              "Resend OTP $_resendSeconds sec(s)",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: size.shortestSide * 0.04,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
