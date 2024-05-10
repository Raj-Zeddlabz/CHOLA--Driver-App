import 'dart:io';
import 'dart:math';

import 'package:chola_driver_flutter/Constants/ApiCollection.dart';
import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/AddDocument.dart';
import 'package:chola_driver_flutter/Widgets/BottomLine.dart';
import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
import 'package:chola_driver_flutter/Widgets/Field.dart';
import 'package:chola_driver_flutter/Widgets/ImagePicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class VehicleDetails extends StatefulWidget {
  const VehicleDetails({
    super.key,
  });

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController vehicleModelController = TextEditingController();
  TextEditingController vehicleColorController = TextEditingController();
  TextEditingController vehicleYearController = TextEditingController();
  TextEditingController vehicleCompanyController = TextEditingController();
  TextEditingController licensePlateController = TextEditingController();
  bool isVerify = false;
  DateTime? selectedDate;
  String showYear = 'Select Year';
  DateTime? _selectedYear = DateTime.now();
  File? _vehicleImageFile;
  late SharedPreferences _prefs;
  bool isLoading = false;
  String vehicleImageUrl = '';
/*
   * This code defines the _VehicleDetailsState class, which is a stateful widget that manages the state of the vehicle details screen. It includes methods for loading and saving data, uploading files, and selecting a year. The class also includes text editing controllers and variables to store the state of various input fields.

  Main functionalities:

  Managing the state of the vehicle details screen
  Loading and saving data using shared preferences
  Uploading a file to Firebase storage
  Selecting a year using a year picker dialog
  Methods
  initState(): Initializes the state of the widget and calls the _loadData() method.
  dispose(): Cleans up resources when the widget is removed from the tree.
  _loadData(): Loads data from shared preferences and updates the state of the widget.
  _saveData(): Saves data to shared preferences and uploads the vehicle image file to Firebase storage.
  uploadFile(): Uploads a file to Firebase storage and returns the download URL.
  _selectYear(): Shows a year picker dialog and updates the selected year in the state.
  Fields
  vehicleTypeController: A text editing controller for the vehicle type input field.
  vehicleModelController: A text editing controller for the vehicle model input field.
  vehicleColorController: A text editing controller for the vehicle color input field.
  vehicleYearController: A text editing controller for the vehicle year input field.
  vehicleCompanyController: A text editing controller for the vehicle company input field.
  licensePlateController: A text editing controller for the license plate input field.
  isVerify: A boolean variable to track the verification status.
  selectedDate: A nullable DateTime variable to store the selected date.
  showYear: A string variable to display the selected year.
  _selectedYear: A nullable DateTime variable to store the selected year.
  _vehicleImageFile: A nullable File variable to store the selected vehicle image file.
  _prefs: A late-initialized SharedPreferences variable.
  isLoading: A boolean variable to track the loading state.
  vehicleImageUrl: A string variable to store the URL of the vehicle image.
  Usage example
  _VehicleDetailsState vehicleDetailsState = _VehicleDetailsState();
  vehicleDetailsState.initState();
  vehicleDetailsState.dispose();
  vehicleDetailsState._loadData();
  vehicleDetailsState._saveData();
  vehicleDetailsState.uploadFile(file, 'docsName', 'fileName');
  vehicleDetailsState._selectYear(context);
 */
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }
//load data
  Future<void> _loadData() async {
    _prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        vehicleTypeController.text = _prefs.getString('vehicleType') ?? '';
        vehicleCompanyController.text =
            _prefs.getString('vehicleCompany') ?? '';
        vehicleModelController.text = _prefs.getString('vehicleModel') ?? '';
        vehicleYearController.text = _prefs.getString('vehicleYear') ?? '';
        vehicleColorController.text = _prefs.getString('vehicleColor') ?? '';
        licensePlateController.text = _prefs.getString('licensePlate') ?? '';

        // Load front and back image URLs
        String? vehicleImageUrl = _prefs.getString('vehicleImageUrl');
        // String? backImageUrl = _prefs.getString('AadharCardBackUrl');
        print(vehicleImageUrl);
        // print(backImageUrl);

        if (vehicleImageUrl != null) {
          _vehicleImageFile = File(vehicleImageUrl);
        }
      });
    }
  }
//save data
  Future<void> _saveData() async {
    setState(() {
      isLoading = true;
    });
    await _prefs.setString('vehicleType', vehicleTypeController.text);
    await _prefs.setString('vehicleCompany', vehicleCompanyController.text);
    await _prefs.setString('vehicleModel', vehicleModelController.text);
    await _prefs.setString('vehicleYear', vehicleYearController.text);
    await _prefs.setString('vehicleColor', vehicleColorController.text);
    await _prefs.setString('licensePlate', licensePlateController.text);
    if (_vehicleImageFile != null) {
      vehicleImageUrl =
          await uploadFile(_vehicleImageFile, 'vehicleImage', 'vehicleImage');
      if (mounted) {
        await _prefs.setString('vehicleImageUrl', vehicleImageUrl);
      }
    }
    // if (_backImageFile != null) {
    //   String backImageUrl =
    //       await uploadFile(_backImageFile, 'AadharCard', 'AadharCardBack');
    //   if (mounted) {
    //     await _prefs.setString('AadharCardBackUrl', backImageUrl);
    //   }
    // }
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

  _selectYear(BuildContext context) async {
    int? selectedYear = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Year',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          contentTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.9,
            child: YearPicker(
              selectedDate: _selectedYear,
              firstDate: DateTime(DateTime.now().year - 100, 1),
              lastDate: DateTime.now(),
              onChanged: (DateTime dateTime) {
                print(dateTime.year);
                setState(() {
                  _selectedYear = dateTime;
                  showYear = '${dateTime.year}';
                  vehicleYearController.text = "$showYear";
                });
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );

    // if (_selectedYear != null) {
    //   setState(() {
    //     selectedDate = DateTime(_selectedYear);

    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    String dropdownValue1 = 'Maruti-Suzuki';

    return Padding(
      padding: EdgeInsets.only(
        top: statusBarHeight,
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          preferredHeight: size.height * 0.08,
          title: "Vehicle Details",
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SizedBox(
          height: size.height - statusBarHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
              vertical: size.height * 0.02,
            ),
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                Text(
                  '\t\tVehicle Type',
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
                    labelText: "Vehicle Type",
                    hintText: "Enter Your Vehicle Type",
                    vertical: 0.04,
                    horizontal: 0.04,
                    keyboardType: TextInputType.text,
                    fieldController: vehicleTypeController,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  '\t\tVehicle Company/Make',
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
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    value: dropdownValue1,
                    onChanged: (String? newValue) {
                      setState(() {
                        if (Constants.vehicleCompany.contains(newValue)) {
                          dropdownValue1 = newValue!;
                        }
                      });
                    },
                    items: Constants.vehicleCompany
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  '\t\tVehicle Model',
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
                    labelText: "Vehicle Model",
                    hintText: "Enter Your Vehicle Model",
                    vertical: 0.04,
                    horizontal: 0.04,
                    keyboardType: TextInputType.text,
                    fieldController: vehicleModelController,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  '\t\tVehicle Year',
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
                    controller: vehicleYearController,
                    onTap: () => _selectYear(context),
                    readOnly: true,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.calendar_month,
                      ),
                      enabled: true,
                      filled: true,
                      fillColor: Colors.white,
                      // labelText: 'Vehicle Year',
                      // labelStyle: TextStyle(
                      //   // color: widget.color ?? ThemeData.light().colorScheme.primary,
                      //   fontWeight: FontWeight.w900,
                      //   fontSize: MediaQuery.of(context).size.width * 0.045,
                      // ),
                      hintText: 'Enter Vehicle Year',
                      // icon: widget.icon,
                      contentPadding: EdgeInsets.symmetric(
                        vertical:
                            MediaQuery.of(context).size.shortestSide * 0.03,
                        horizontal:
                            MediaQuery.of(context).size.shortestSide * 0.04,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please Enter a valid Year';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  '\t\tVehicle Color',
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
                    labelText: "Vehicle Color",
                    hintText: "Enter Your Vehicle Color",
                    vertical: 0.04,
                    horizontal: 0.04,
                    keyboardType: TextInputType.text,
                    fieldController: vehicleColorController,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  '\t\tLicense Plate Number',
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
                    labelText: "License Plate Number",
                    hintText: "Enter Your License Plate Number",
                    vertical: 0.04,
                    horizontal: 0.04,
                    keyboardType: TextInputType.text,
                    fieldController: licensePlateController,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  '\t\tPicture of Your Vehicle',
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
                Text(
                  '(Click Again to reselect)',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
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
                    docsName: 'Vehicle',
                    fileName: 'VehicleImage',
                    onImagePicked: (file) {
                      setState(() {
                        _vehicleImageFile = file;
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
                              if (vehicleTypeController.length == 0) {
                                Constants.showError(
                                  context,
                                  "Please Enter Vehicle Type",
                                );
                              } else if (vehicleModelController.length == 0) {
                                Constants.showError(
                                  context,
                                  "Please Enter Vehicle Model",
                                );
                              } else if (vehicleYearController.length == 0) {
                                Constants.showError(
                                  context,
                                  "Please Enter Valid Vehicle Year",
                                );
                              } else if (vehicleColorController.length == 0) {
                                Constants.showError(
                                  context,
                                  "Please Enter Vehicle Color",
                                );
                              } else if (licensePlateController.length == 0) {
                                Constants.showError(
                                  context,
                                  "Please Enter License Plate Number",
                                );
                              } else if (_vehicleImageFile == null) {
                                Constants.showError(
                                  context,
                                  "Please Attach/Take Picture of Vehicle",
                                );
                              } else {
                                await _saveData();
                                // print(vehicleTypeController.text);
                                // print(Constants.vehicleCompany[max(
                                //         Constants.vehicleCompany.indexOf(
                                //             vehicleCompanyController.text),
                                //         0)]
                                //     .toString());
                                // print(vehicleModelController.text);
                                // print(vehicleYearController.text);
                                // print(vehicleColorController.text);
                                // print(licensePlateController.text);
                                // print(vehicleImageUrl);
                                // await ApiCollection.updateVehicleDetails(
                                //   vehicleTypeController.text,
                                //   Constants.vehicleCompany[max(
                                //           Constants.vehicleCompany.indexOf(
                                //               vehicleCompanyController.text),
                                //           0)]
                                //       .toString(),
                                //   vehicleModelController.text,
                                //   vehicleYearController.text,
                                //   vehicleColorController.text,
                                //   licensePlateController.text,
                                //   vehicleImageUrl,
                                // );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddDocument(
                                      isVerifyAadhar: true,
                                      isVerifyPan: true,
                                      isVerifyDriverLicense: true,
                                      isVerifyPermanentAddress: true,
                                      isVerifyPhoto: true,
                                      isVerifyVehicle: true,
                                      isVerifyBankAccount: true,
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
              ],
            ),
          ),
        ),
        // bottomNavigationBar:
      ),
    );
  }
}
