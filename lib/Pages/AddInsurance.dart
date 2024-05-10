import 'dart:io';

import 'package:chola_driver_flutter/Constants/ApiCollection.dart';
import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/AddDocument.dart';
import 'package:chola_driver_flutter/Widgets/BottomLine.dart';
import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
import 'package:chola_driver_flutter/Widgets/Field.dart';
import 'package:chola_driver_flutter/Widgets/ImagePicker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Insurance extends StatefulWidget {
  const Insurance({
    super.key,
  });

  @override
  State<Insurance> createState() => _InsuranceState();
}

class _InsuranceState extends State<Insurance> {
  TextEditingController insuranceController = TextEditingController();
  bool isVerify = false;
  File? _insuranceFrontImageFile;
  File? _insuranceBackImageFile;
  TextEditingController expiryController = TextEditingController();
  DateTime? selectedDate;
  FocusNode _insuranceFocus = FocusNode();
  bool isLoading = false;
  late SharedPreferences _prefs;
  String frontImageUrl = '';
  String backImageUrl = '';

  @override
  void initState() {
    super.initState();
    _initializePrefs();
    _insuranceFocus.requestFocus();
  }
// Intialize Preference 
  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _loadData();
  }
//load data
  Future<void> _loadData() async {
    // if (_prefs == null) {
    //   _prefs = await SharedPreferences.getInstance();
    // }
    if (mounted) {
      setState(() {
        insuranceController.text = _prefs.getString('insurance') ?? '';
        expiryController.text = _prefs.getString('insuranceExpiry') ?? '';

        // Load front and back image URLs
        String? frontImageUrl = _prefs.getString('insuranceFrontUrl');
        String? backImageUrl = _prefs.getString('insuranceBackUrl');
        print(frontImageUrl);
        print(backImageUrl);

        if (_insuranceFrontImageFile != null)
          _insuranceFrontImageFile = File(frontImageUrl!.toString());
        if (_insuranceBackImageFile != null)
          _insuranceBackImageFile = File(backImageUrl!.toString());
      });
    }
  }
//save data
  Future<void> _saveData() async {
    setState(() {
      isLoading = true;
    });
    await _prefs.setString('insurance', insuranceController.text);
    await _prefs.setString('insuranceExpiry', expiryController.text);
    if (_insuranceFrontImageFile != null) {
      frontImageUrl = await uploadFile(
          _insuranceFrontImageFile, 'insurance', 'insuranceFront');
      if (mounted) {
        await _prefs.setString('insuranceFrontUrl', frontImageUrl);
      }
    }
    if (_insuranceBackImageFile != null) {
      backImageUrl = await uploadFile(
          _insuranceBackImageFile, 'insurance', 'insuranceBack');
      if (mounted) {
        await _prefs.setString('insuranceBackUrl', backImageUrl);
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
          title: "Car Insurance",
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
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02,
                ),
                child: Image.asset(
                  'assets/Insurance.png',
                  // width: double.maxFinite,
                ),
              ),
              Text(
                'Add Your Insurance',
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
                  hintText: "Enter Your Insurance Number",
                  vertical: 0.04,
                  horizontal: 0.04,
                  focusNode: _insuranceFocus,
                  keyboardType: TextInputType.text,
                  fieldController: insuranceController,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
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
                'Car Insurance Front',
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
                  docsName: 'Insurance',
                  fileName: 'InsuranceFront',
                  onImagePicked: (file) {
                    setState(() {
                      _insuranceFrontImageFile = file;
                    });
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'Car Insurance Back',
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
                  color: Colors.black,
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
                  docsName: 'Insurance',
                  fileName: 'InsuranceBack',
                  onImagePicked: (file) {
                    setState(() {
                      _insuranceBackImageFile = file;
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
                            if (insuranceController.text.isEmpty) {
                              Constants.showError(
                                context,
                                "Please enter your Insurance number",
                              );
                            } else if (_insuranceFrontImageFile == null) {
                              Constants.showError(
                                context,
                                "Please Attach/Take Picture of Insurance Front",
                              );
                            } else if (_insuranceBackImageFile == null) {
                              Constants.showError(
                                context,
                                "Please Attach/Take Picture of Insurance Back",
                              );
                            } else {
                              // await _saveData();
                              setState(() {
                                isLoading = true;
                              });
                              print(insuranceController.text);
                              print(expiryController.text);
                              print(frontImageUrl);
                              print(backImageUrl);
                              try {
                                // await ApiCollection.updateCarInsurance(
                                //   insuranceController.text,
                                //   expiryController.text,
                                //   frontImageUrl,
                                //   backImageUrl,
                                // );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddDocument(
                                      isVerifyAadhar: true,
                                      isVerifyPan: true,
                                      isVerifyDriverLicense: true,
                                      isVerifyRC: true,
                                      isVerifyInsurance: true,
                                      isVerifyPermanentAddress: true,
                                      isVerifyPhoto: true,
                                      isVerifyVehicle: true,
                                      isVerifyBankAccount: true,
                                    ),
                                  ),
                                );
                              } catch (e) {
                                Constants.showError(
                                    context, 'Something went wrong! Try Again');
                                print('Expection - $e');
                                setState(() {
                                  isLoading = false;
                                });
                              }
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
                      bottomLine(),
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
