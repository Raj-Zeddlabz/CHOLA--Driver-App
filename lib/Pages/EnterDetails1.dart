import 'dart:convert';

import 'package:chola_driver_flutter/Constants/ApiCollection.dart';
import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/PartnerPreForm.dart';
import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
import 'package:chola_driver_flutter/Widgets/Field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:country_state_city_pro/country_state_city_pro.dart';

class EnterDetails1 extends StatefulWidget {
  final String jwt;
  const EnterDetails1({required this.jwt, super.key});

  @override
  State<EnterDetails1> createState() => _EnterDetails1State();
}

class _EnterDetails1State extends State<EnterDetails1> {
  final _formKey = GlobalKey<FormState>();
  final _referralController = TextEditingController();
  FocusNode _cityFocusNode = FocusNode();
  FocusNode _referralFocusNode = FocusNode();
  Map<String, dynamic> data = {};
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();

  // updateCity(String cityName) async {
  //   print('dhjbcjdkbcdkj');
  //   // print(dialCode.runtimeType);
  //   var response = await http.put(
  //     Uri.parse('https://chola-web-app.azurewebsites.net/api/auth/update'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${widget.jwt}',
  //     },
  //     body: jsonEncode({
  //       'cityName': cityName,
  //     }),
  //   );
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     print(json.decode(response.body).runtimeType);
  //     return json.decode(response.body);
  //   } else {
  //     throw Exception('Failed to update City.');
  //   }
  // }


  
  // Builds the widget tree for the current [BuildContext].
  //
  // The [BuildContext] is used to look up the current [Widget] and [Theme] information.
  // Returns the built [Widget] tree.
  @override
  void initState() {
    super.initState();
    _cityFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(
        top: statusBarHeight,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: CustomAppBar(
          title: "Location Details",
          preferredHeight: size.height * 0.08,
        ),
        body: SizedBox(
          height: size.height - MediaQuery.of(context).padding.top,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.height * 0.04,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Select Location',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: size.shortestSide * 0.05,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    CountryStateCityPicker(
                      country: country,
                      state: state,
                      city: city,
                      dialogColor: Colors.white,
                      textFieldDecoration: InputDecoration(
                        fillColor: Theme.of(context).colorScheme.onTertiary,
                        filled: true,
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        icon: Icon(
                          Icons.location_city,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onBackground,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Refferal Code (optional)',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: size.shortestSide * 0.05,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    Field(
                      labelText: "",
                      hintText: "Enter Your Referral Code",
                      vertical: 0.03,
                      icon: Icon(
                        Icons.discount,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      horizontal: 0.04,
                      fieldController: _referralController,
                      focusNode: _referralFocusNode,
                    ),
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    AgreeButton(
                      buttonText: "Next",
                      onPressed: () async {
                        // if (!_formKey.currentState!.validate()) {
                          try {
                            // Map<String, dynamic> result =
                            //     await ApiCollection.updateCity(
                            //   city.text.toUpperCase(),
                            // );

                            // setState(() {
                            //   data = result;
                            //   Constants.user_data = result;
                            // });
                            // print(data["user"]['cityName']);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PartnerPreForm(),
                              ),
                            );
                          } catch (e) {
                            print('Exception: $e');
                          }
                        // }
                      },
                      padding: 0.65,
                      borderRadius: 12,
                      suffixWidget: Icon(
                        Icons.double_arrow,
                        color: Colors.white,
                      ),
                      fontSize: size.shortestSide * 0.05333,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
