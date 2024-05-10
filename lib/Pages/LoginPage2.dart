// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_element

import 'dart:convert';

import 'package:chola_driver_flutter/Constants/ApiCollection.dart';
import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/EmailVerify.dart';
import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
import 'package:chola_driver_flutter/Widgets/Field.dart';
import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';
import 'package:http/http.dart' as http;

class LoginPage2 extends StatefulWidget {
  final String jwt;
  LoginPage2({required this.jwt, super.key});

  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  TextEditingController email = new TextEditingController();
  EmailOTP myauth = EmailOTP();
  FocusNode _emailFocusNode = FocusNode();
  final _emailFormKey = GlobalKey<FormState>();
  Map<String, dynamic> data = {};
  // createEmail(String email) async {
  //   print('dhjbcjdkbcdkj');
  //   // print(dialCode.runtimeType);
  //   var response = await http.put(
  //     Uri.parse('https://chola-web-app.azurewebsites.net/api/auth/update'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${widget.jwt}',
  //     },
  //     body: jsonEncode({
  //       'email': email,
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
    _emailFocusNode.requestFocus();
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    // Validates the given email address using a regular expression pattern.
    bool _isValidEmail(String email) {
      String emailPattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
      RegExp regExp = RegExp(emailPattern);
      return regExp.hasMatch(email);
    }

    return Padding(
      padding: EdgeInsets.only(
        top: statusBarHeight,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: CustomAppBar(
          title: "Enter Email",
          preferredHeight: size.height * 0.08,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.03,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _emailFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Enter Your Email Address',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w700,
                      fontSize: size.shortestSide * 0.06,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Field(
                    labelText: "",
                    hintText: "Enter Your Email Address",
                    vertical: 0.03,
                    horizontal: 0.04,
                    icon: Icon(
                      Icons.email,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    snackbarText: 'Please enter a Valid Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty || !_isValidEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    // onChanged: (value) => _isValidEmail,
                    fieldController: email,
                    focusNode: _emailFocusNode,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  AgreeButton(
                    buttonText: "Next",
                    onPressed: () async {
                      print(Constants.phoneNo);
                      try {
                        if (_emailFormKey.currentState!.validate()) {
                          myauth.setTheme(theme: "v1");
                          myauth.setConfig(
                            appEmail: "cholachariots@gmail.com",
                            appName: "Chola Chariots",
                            userEmail: email.text,
                            otpLength: 6,
                            otpType: OTPType.digitsOnly,
                          );
                          if (await myauth.sendOTP() == true) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("OTP has been sent"),
                            ));
                            Map<String, dynamic> result =
                                await ApiCollection.createEmail(
                              email.text,
                            );

                            setState(() {
                              data = result;
                              Constants.user_data = result;
                            });
                            print(data['phoneNoVerified']);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EmailVerify(
                                  email: email.text,
                                  jwt: data['jwt'] as String,
                                  // jwt: "",
                                  myauth: myauth,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Oops, OTP send failed"),
                            ));
                          }
                          // Map<String, dynamic> result = await createEmail(
                          //   email.text,
                          // );

                          // setState(() {
                          //   data = result;
                          // });
                          // print(data['phoneNoVerified']);

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => EmailVerify(
                          //       email: email.text,
                          //       jwt: data['jwt'] as String,
                          //     ),
                          //   ),
                          // );
                        }
                      } catch (e) {
                        print('Exception: $e');
                      }
                    },
                    padding: 0.65,
                    borderRadius: 12,
                    suffixWidget: Icon(
                      Icons.double_arrow,
                      color: Colors.white,
                    ),
                    fontSize: size.shortestSide * 0.05333,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  // FittedBox(
                  //   fit: BoxFit.scaleDown,
                  //   child: Text(
                  //     'By continuing you may receive an Email for verification.\nStandard Message and data rates may apply.',
                  //     overflow: TextOverflow.ellipsis,
                  //     maxLines: 2,
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.w400,
                  //       fontSize: size.shortestSide * 0.05,
                  //     ),
                  //   ),
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
