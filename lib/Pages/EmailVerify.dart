import 'dart:async';
import 'dart:convert';
import 'package:chola_driver_flutter/Constants/ApiCollection.dart';
import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/EnterDetails.dart';
import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;

class EmailVerify extends StatefulWidget {
  final String email;
  final String jwt;
  final EmailOTP myauth;
  EmailVerify(
      {Key? key, required this.email, required this.jwt, required this.myauth})
      : super(key: key);

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  Timer? _resendTimer;
  int _resendSeconds = 120;
  bool _showResendButton = false;

  TextEditingController otp = new TextEditingController();
  // EmailOTP myauth = EmailOTP();
  final _emailFormKey = GlobalKey<FormState>();
  Map<String, dynamic> data = {};
  // verifyEmail() async {
  //   print('dhjbcjdkbcdkj');
  //   // print(dialCode.runtimeType);
  //   var response = await http.put(
  //     Uri.parse('https://chola-web-app.azurewebsites.net/api/auth/update'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${widget.jwt}',
  //     },
  //     body: jsonEncode({
  //       'verified': true,
  //     }),
  //   );
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     print(json.decode(response.body).runtimeType);
  //     return json.decode(response.body);
  //   } else {
  //     throw Exception('Failed to verify Email.');
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
//Timer for resend otp
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
// Resend otp
  void resendOTP() {
    // Resend OTP logic
    setState(() {
      _resendSeconds = 120;
      _showResendButton = false;
    });
    startResendTimer();
  }

  @override
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
          title: "Email OTP",
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
                    "Enter the 6-digit code sent to " + widget.email,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
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
                      controller: otp,
                      onCompleted: (value) async {
                        try {
                          if (await widget.myauth.verifyOTP(otp: otp.text) ==
                              true) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("OTP is verified"),
                            ));
                            Map<String, dynamic> result =
                                await ApiCollection.verifyEmail();

                            setState(() {
                              data = result;
                              Constants.user_data = result;
                            });
                            print(data['phoneNoVerified']);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EnterDetails(
                                  jwt: data['jwt'] as String,
                                  // jwt: "",
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Invalid OTP"),
                            ));
                          }
                          // Map<String, dynamic> result = await verifyEmail();

                          // setState(() {
                          //   data = result;
                          // });
                          // print(data['phoneNoVerified']);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => EnterDetails(
                          //       jwt: data['jwt'] as String,
                          //     ),
                          //   ),
                          // );
                        } catch (e) {
                          print('Exception: $e');
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  // _showResendButton
                  //     ? AgreeButton(
                  //         onPressed: resendOTP,
                  //         buttonText: "Resend OTP",
                  //         padding: 0.6,
                  //       )
                  //     : Text(
                  //         "You can resend OTP in $_resendSeconds sec(s)",
                  //         overflow: TextOverflow.ellipsis,
                  //         maxLines: 1,
                  //         textAlign: TextAlign.center,
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.w600,
                  //           fontSize: size.shortestSide * 0.05,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  AgreeButton(
                    buttonText: "Confirm",
                    onPressed: () async {
                      try {
                        if (await widget.myauth.verifyOTP(otp: otp.text) ==
                            true) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("OTP is verified"),
                          ));
                          Map<String, dynamic> result =
                              await ApiCollection.verifyEmail();

                          setState(() {
                            data = result;
                            Constants.user_data = result;
                          });
                          print(data['phoneNoVerified']);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EnterDetails(
                                jwt: data['jwt'] as String,
                                // jwt: "",
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Invalid OTP"),
                          ));
                        }
                        // Map<String, dynamic> result = await verifyEmail();

                        // setState(() {
                        //   data = result;
                        // });
                        // print(data['phoneNoVerified']);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => EnterDetails(
                        //       jwt: data['jwt'] as String,
                        //     ),
                        //   ),
                        // );
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
