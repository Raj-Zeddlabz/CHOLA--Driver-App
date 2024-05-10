import 'dart:convert';
import 'dart:math';

import 'package:chola_driver_flutter/Constants/ApiCollection.dart';
import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/EnterDetails1.dart';
import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
// import 'package:chola_driver_flutter/Widgets/Date.dart';
import 'package:chola_driver_flutter/Widgets/DropDown.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:chola_driver_flutter/Widgets/Field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EnterDetails extends StatefulWidget {
  final String jwt;
  const EnterDetails({required this.jwt, Key? key}) : super(key: key);

  @override
  State<EnterDetails> createState() => _EnterDetailsState();
}

class _EnterDetailsState extends State<EnterDetails> {
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _genderController = TextEditingController();
  final _dobController = TextEditingController();
  final _bloodgroupController = TextEditingController();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  Map<String, dynamic> data = {};
  int _selectedDay = DateTime.now().day;
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;
  DateTime dob =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  // createDetails(String firstName, String lastName, int gender, String dob,
  //     int bloodGroup) async {
  //   print('dhjbcjdkbcdkj');
  //   // print(dialCode.runtimeType);
  //   var response = await http.put(
  //     Uri.parse('https://chola-web-app.azurewebsites.net/api/auth/update'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${widget.jwt}',
  //     },
  //     body: jsonEncode({
  //       'firstName': firstName,
  //       'lastName': lastName,
  //       'gender': gender,
  //       'dob': dob,
  //       'bloodGroup': bloodGroup,
  //     }),
  //   );
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     print(json.decode(response.body).runtimeType);
  //     return json.decode(response.body);
  //   } else {
  //     throw Exception('Failed to update Details.');
  //   }
  // }

    /**
     * Creates a DateTime object from the given day, month, and year.
     *
     * @param day The day of the month.
     * @param month The month of the year.
     * @param year The year.
     * @return The DateTime object created from the given day, month, and year.
     */
  DateTime? _dateTime(int? day, int? month, int? year) {
    if (day != null && month != null && year != null) {
      return DateTime(year, month, day);
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _firstNameFocusNode.requestFocus();
    // dob = DateTime.now();
  }


  /// Builds the widget tree for the current [BuildContext].
  ///
  /// The [BuildContext] is used to retrieve the current media size and padding.
  /// The returned widget tree consists of a [Padding] widget that contains a
  /// [Scaffold] widget. The [Scaffold] widget is used to display an app bar and
  /// a body that contains a form. The form is built using a [Form] widget that
  /// contains several form fields such as [Field], [CustomDropDown], and [AgreeButton].
  /// The form fields are used to capture user input such as first name, last name,
  /// date of birth, blood group, and gender. The form fields are validated using
  /// the [FormState.validate] method. If the form is valid, the user's details
  /// are sent to the server using the [ApiCollection.createDetails] method.
  /// If the user is older than 18 years old, an error message is displayed.
  /// If the request is successful, the user is navigated to the [EnterDetails1]
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: CustomAppBar(
          title: "Personal Details",
          preferredHeight: size.height * 0.08,
        ),
        body: SizedBox(
          height: size.height - MediaQuery.of(context).padding.top,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.04,
              ),
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
                          'First Name',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: size.shortestSide * 0.045,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.03,
                    ),
                    Field(
                      labelText: "",
                      hintText: "Enter Your First Name",
                      // icon: Icon(Icons.person),
                      vertical: 0.03,
                      horizontal: 0.04,
                      focusNode: _firstNameFocusNode,
                      snackbarText: 'Please enter your firstname',
                      fieldController: _firstnameController,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Last Name',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: size.shortestSide * 0.045,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.03,
                    ),
                    Field(
                      labelText: "",
                      hintText: "Enter Your Last Name",
                      vertical: 0.03,
                      // icon: Icon(
                      //   Icons.person,
                      // ),
                      horizontal: 0.04,
                      snackbarText: 'Please enter your Lastname',
                      fieldController: _lastnameController,
                      focusNode: _lastNameFocusNode,
                    ),
                    SizedBox(
                      height: size.width * 0.03,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Date of Birth (DOB)',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: size.shortestSide * 0.045,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.03,
                    ),
                    DropdownDatePicker(
                      textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: size.shortestSide * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      boxDecoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onTertiary,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      startYear: 1900,
                      endYear: DateTime.now().year,
                      isExpanded: true,
                      isDropdownHideUnderline: false,
                      isFormValidator: true,
                      inputDecoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),

                      dayFlex: 2,
                      monthFlex: 2,
                      yearFlex: 2,
                      selectedDay: _selectedDay, // optional
                      selectedMonth: _selectedMonth, // optional
                      selectedYear: _selectedYear, // optional
                      onChangedDay: (value) {
                        _selectedDay = int.parse(value!);
                        setState(() {
                          dob = _dateTime(
                              _selectedDay, _selectedMonth, _selectedYear)!;
                        });
                        print('onChangedDay dob : $dob');
                      },
                      onChangedMonth: (value) {
                        _selectedMonth = int.parse(value!);
                        setState(() {
                          dob = _dateTime(
                              _selectedDay, _selectedMonth, _selectedYear)!;
                        });
                        print('onChangedMonth: $dob');
                      },
                      onChangedYear: (value) {
                        _selectedYear = int.parse(value!);
                        setState(() {
                          dob = _dateTime(
                              _selectedDay, _selectedMonth, _selectedYear)!;
                        });
                        print('onChangedYear: $dob');
                      },
                      // icon: Icon(Icons.calendar_month),
                    ),
                    SizedBox(
                      height: size.width * 0.03,
                    ),
                    Row(
                      children: [
                        CustomDropDown(
                            controller: _bloodgroupController,
                            onChanged: (value) {
                              setState(() {
                                _bloodgroupController.text = value!;
                              });
                            },
                            ListOfDropDown: Constants.bloodGroup,
                            labelText: "Blood Group",
                            // icon: Icon(Icons.bloodtype),
                            vertical: 0.02,
                            horizontal: 0.02),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        CustomDropDown(
                          controller: _genderController,
                          onChanged: (value) {
                            setState(() {
                              _genderController.text = value!;
                            });
                          },
                          ListOfDropDown: Constants.gender,
                          labelText: "Gender",
                          // icon: const Icon(
                          //   Icons.transgender_outlined,
                          // ),
                          vertical: 0.02,
                          horizontal: 0.02,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    AgreeButton(
                      buttonText: "Next",
                      onPressed: () async {
                        try {
                          if (_formKey.currentState!.validate()) {
                            print(dob);
                            // print(DateTime.now());
                            if (!dob.isBefore(DateTime.now()
                                .subtract(Duration(days: 18 * 365)))) {
                              Constants.showError(
                                context,
                                '*You must be 18 years Old',
                              );
                            } else {
                              Map<String, dynamic> result =
                                  await ApiCollection.createDetails(
                                _firstnameController.text,
                                _lastnameController.text,
                                max(
                                    Constants.gender
                                        .indexOf(_genderController.text),
                                    0),
                                dob.toString(),
                                max(
                                    Constants.bloodGroup
                                        .indexOf(_bloodgroupController.text),
                                    0),
                              );

                              setState(() {
                                data = result;
                                Constants.user_data = result;
                                Constants.firstName = _firstnameController.text;
                              });
                              print(data['dob']);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EnterDetails1(
                                    jwt: data['jwt'] as String,
                                    // jwt: "",
                                  ),
                                ),
                              );
                            }
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
