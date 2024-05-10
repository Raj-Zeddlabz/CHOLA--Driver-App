import 'dart:io';

import 'package:chola_driver_flutter/Constants/ApiCollection.dart';
import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/AddDocument.dart';
import 'package:chola_driver_flutter/Widgets/BottomLine.dart';
import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
// import 'package:chola_driver_flutter/Widgets/Date.dart';
import 'package:chola_driver_flutter/Widgets/Field.dart';
import 'package:chola_driver_flutter/Widgets/ImagePicker.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DrivingLicense extends StatefulWidget {
  const DrivingLicense({
    super.key,
  });

  @override
  State<DrivingLicense> createState() => _DrivingLicenseState();
}

class _DrivingLicenseState extends State<DrivingLicense> {
  TextEditingController licenseController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  DateTime? selectedDate;
  bool isVerify = false;
  File? _frontImageFile;
  File? _backImageFile;
  String frontImageUrl = '';
  String backImageUrl = '';
  FocusNode _drivingFocus = FocusNode();
  late SharedPreferences _prefs;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _drivingFocus.requestFocus();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _drivingFocus.dispose();
  }
//load data
  Future<void> _loadData() async {
    _prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        licenseController.text = _prefs.getString('license') ?? '';
        expiryController.text = _prefs.getString('expirydate') ?? '';

        // Load front and back image URLs
        String? frontImageUrl = _prefs.getString('licenseFrontUrl');
        String? backImageUrl = _prefs.getString('licenseBackUrl');
        print(frontImageUrl);
        print(backImageUrl);
        _frontImageFile = frontImageUrl != null ? File(frontImageUrl) : null;
        _backImageFile = backImageUrl != null ? File(backImageUrl) : null;
      });
    }
  }
//save data
  Future<void> _saveData() async {
    setState(() {
      isLoading = true;
    });
    await _prefs.setString('license', licenseController.text);
    await _prefs.setString('expirydate', expiryController.text);
    if (_frontImageFile != null) {
      frontImageUrl =
          await uploadFile(_frontImageFile, 'license', 'licenseFront');
      if (mounted) {
        await _prefs.setString('licenseFrontUrl', frontImageUrl);
      }
    }
    if (_backImageFile != null) {
      backImageUrl = await uploadFile(_backImageFile, 'license', 'licenseBack');
      if (mounted) {
        await _prefs.setString('licenseBackUrl', backImageUrl);
      }
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }
//upload File
  Future<String> uploadFile(
      File? _imageFile, String docsName, String fileName) async {
    if (_imageFile == null) return '';
    final destination = '${Constants.phoneNo}/${docsName}/${fileName}';

    try {
      print('object');
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('${fileName}/');
      print('123');
      await ref.putFile(_imageFile);
      print('object2');
      String downloadURL = await ref.getDownloadURL();
      print('object3');
      print(downloadURL);
      return downloadURL;
    } catch (e) {
      print('error occurred');
      return '';
    }
  }
 /// Selects a date using the `showDatePicker` method and updates the selected date and expiry controller text.
  ///
  /// The function takes a `BuildContext` as a parameter and returns a `Future<void>`.
  ///
  /// The `showDatePicker` method is used to display a date picker dialog and allows the user to select a date.
  /// The `context` parameter is used to build the dialog.
  /// The `initialDate` parameter is set to the current date.
  /// The `firstDate` parameter is set to the current date.
  /// The `lastDate` parameter is set to the year 2100.
  ///
  /// If a date is selected and it is different from the current selected date,
  /// the selected date is updated and the expiry controller text is set to the selected date in the format "YYYY-MM-DD".
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        expiryController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
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
        appBar: CustomAppBar(
          preferredHeight: size.height * 0.08,
          title: "Driving License",
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SizedBox(
          height: size.height - statusBarHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02,
              vertical: size.height * 0.02,
            ),
            child: SingleChildScrollView(
                child: Column(children: [
              Image.asset(
                'assets/DrivingLicense.png',
                width: double.maxFinite,
              ),
              Text(
                'Add Your Driving License',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: size.shortestSide * 0.0533,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.height * 0.02,
                ),
                child: Field(
                  labelText: "",
                  focusNode: _drivingFocus,
                  hintText: "Enter Your License Number",
                  vertical: 0.04,
                  horizontal: 0.04,
                  maxLength: 16,
                  keyboardType: TextInputType.text,
                  fieldController: licenseController,
                ),
              ),
              Text(
                'Expiry Date',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: size.shortestSide * 0.0533,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.height * 0.02,
                ),
                child: TextFormField(
                  controller: expiryController,
                  onTap: () => _selectDate(context),
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.calendar_month,
                    ),
                    enabled: true,
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "",
                    labelStyle: TextStyle(
                      // color: widget.color ?? ThemeData.light().colorScheme.primary,
                      fontWeight: FontWeight.w900,
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                    ),
                    hintText: "Enter the Expiry Date",
                    // icon: widget.icon,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.shortestSide * 0.03,
                      horizontal:
                          MediaQuery.of(context).size.shortestSide * 0.04,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid expiry date';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'Driving License Front',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: size.shortestSide * 0.0533,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              Text(
                '(Click Again to reselect)',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: size.shortestSide * 0.027,
                  color: Theme.of(context).colorScheme.onBackground,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                ),
                child: ImagePickerButton(
                  docsName: 'DrivingLicense',
                  fileName: 'DrivingLicenseFront',
                  onImagePicked: (file) {
                    setState(() {
                      _frontImageFile = file;
                    });
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'Driving License Back',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: size.shortestSide * 0.0533,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              Text(
                '(Click Again to reselect)',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: size.shortestSide * 0.027,
                  color: Theme.of(context).colorScheme.onBackground,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                ),
                child: ImagePickerButton(
                  docsName: 'DrivingLicense',
                  fileName: 'DrivingLicenseBack',
                  onImagePicked: (file) {
                    setState(() {
                      _backImageFile = file;
                    });
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                height: size.height * 0.15,
                child: Center(
                  child: Column(
                    children: [
                      Visibility(
                        visible: !isLoading,
                        child: AgreeButton(
                          buttonText: "Save & Continue",
                          onPressed: () async {
                            if (licenseController.length > 16) {
                              Constants.showError(
                                context,
                                "Please enter a valid License number. License numbers in India are up to 16 characters long.",
                              );
                            } else if (_frontImageFile == null) {
                              Constants.showError(
                                context,
                                "Please upload a valid Front Image of your driving license .",
                              );
                            } else if (_backImageFile == null) {
                              Constants.showError(
                                context,
                                "Please upload a valid Back Image of your driving license .",
                              );
                            } else {
                              await _saveData();
                              // await ApiCollection.updateDrivingLicense(
                              //   licenseController.text,
                              //   expiryController.text,
                              //   frontImageUrl,
                              //   backImageUrl,
                              // );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddDocument(
                                    isVerifyPermanentAddress: true,
                                    isVerifyAadhar: true,
                                    isVerifyDriverLicense: true,
                                    isVerifyPan: true,
                                    isVerifyPhoto: true,
                                  ),
                                ),
                              );
                            }
                          },
                          padding: 0.7,
                        ),
                      ),
                      Visibility(
                        visible: isLoading,
                        child: CircularProgressIndicator(),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      // Expanded(
                      //   child: LayoutBuilder(builder: (context, constraints) {
                      //     double fontSize = constraints.maxWidth * 0.04;
                      //     return Text(
                      //       'Upload all Documents to start earning with CHOLA.',
                      //       overflow: TextOverflow.ellipsis,
                      //       maxLines: 1,
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.w500,
                      //         fontSize: fontSize,
                      //         color: Colors.black,
                      //       ),
                      //     );
                      //   }),
                      // ),
                      bottomLine(),
                    ],
                  ),
                ),
              ),
            ])),
          ),
        ),
        // bottomNavigationBar:
      ),
    );
  }
}
