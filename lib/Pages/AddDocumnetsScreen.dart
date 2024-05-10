import 'dart:io';

import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/AddDocument.dart';
import 'package:chola_driver_flutter/Pages/HomePage.dart';
// import 'package:chola_driver_flutter/Widgets/BottomLine.dart';
import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
import 'package:chola_driver_flutter/Widgets/Field.dart';
import 'package:chola_driver_flutter/Widgets/ImagePicker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddDocumnetsScreen extends StatefulWidget {
  const AddDocumnetsScreen({super.key});

  @override
  State<AddDocumnetsScreen> createState() => _AddDocumnetsScreenState();
}

class _AddDocumnetsScreenState extends State<AddDocumnetsScreen> {
  final TextEditingController docsNameController = TextEditingController();
  final TextEditingController uploadDateController = TextEditingController();
  FocusNode docsNameFocus = FocusNode();
  DateTime? selectedDate;
  File? _file;
  late SharedPreferences _prefs;
  bool isLoading = false;
  @override
      /**
     * Initializes the state of the widget.
     *
     * This function is called when the widget is inserted into the tree. It is responsible for
     * initializing the state of the widget and requesting focus for the `docsNameFocus` object.
     * It also calls the `_selectDate()` function to select the current date.
     *
     * Parameters:
     * - None
     *
     * Return:
     * - None
     */
  void initState() {
    super.initState();
    _initializePrefs();
    docsNameFocus.requestFocus();
    // uploadDateController.text = _getCurrentDate();
    _selectDate(context);
  }

  _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();

    if (selectedDate != now) {
      setState(() {
        selectedDate = now;
        uploadDateController.text = "${now.year} / ${now.month} / ${now.day}";
      });
    }
  }

  /// Initializes the SharedPreferences instance and assigns it to the `_prefs` variable.
  ///
  /// This function uses the `SharedPreferences.getInstance()` method to retrieve the instance of the SharedPreferences.
  /// It then assigns the instance to the `_prefs` variable.
  ///
  /// Returns: A `Future<void>` that completes when the SharedPreferences instance is retrieved and assigned to `_prefs`.
  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    // _loadData();
  }

  // Future<void> _loadData() async {
  //   _prefs = await SharedPreferences.getInstance();
  //   if (mounted) {
  //     setState(() {
  //       docsNameController.text = _prefs.getString('additionalDocs') ?? '';
  //       uploadDateController.text = _prefs.getString('uploaddate') ?? '';

  //       // Load front and back image URLs
  //       String? frontImageUrl = _prefs.getString('fileUrl');
  //       // String? backImageUrl = _prefs.getString('licenseBackUrl');
  //       print(frontImageUrl);
  //       // print(backImageUrl);
  //       _file = frontImageUrl != null ? File(frontImageUrl) : null;
  //       // _backImageFile = backImageUrl != null ? File(backImageUrl) : null;
  //     });
  //   }
  // }
      /// Saves the data to the SharedPreferences instance.
    ///
    /// This function sets the `isLoading` state to `true` and saves the `docsNameController` and `uploadDateController` text values to the SharedPreferences instance.
    /// If `_file` is not null, it uploads the file using the `uploadFile` function and saves the returned URL to the SharedPreferences instance.
    /// Finally, it sets the `isLoading` state to `false`.
    ///
    /// Returns: A `Future<void>` that completes when the data has been saved.
  Future<void> _saveData() async {
    setState(() {
      isLoading = true;
    });
    await _prefs.setString('additionalDocs', docsNameController.text);
    await _prefs.setString('uploaddate', uploadDateController.text);
    if (_file != null) {
      String frontImageUrl =
          await uploadFile(_file, 'additionalDocs', 'additionalDocs');
      if (mounted) {
        await _prefs.setString('fileUrl', frontImageUrl);
      }
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }
  /// Uploads a file to Firebase Storage and returns the download URL.
  ///
  /// Parameters:
  /// - `_imageFile`: The file to be uploaded.
  /// - `docsName`: The name of the document.
  /// - `fileName`: The name of the file.
  ///
  /// Returns:
  /// - A `Future<String>` that resolves to the download URL of the uploaded file.
  ///
  /// Throws:
  /// - `Exception` if an error occurs during the upload process.
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

  // _selectDate(BuildContext context) async {
  //   print('asdfg');
  //   final DateTime picked =
  //       DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  //   print(picked);

  //   if (picked != selectedDate) {
  //     print('123');
  //     setState(() {
  //       selectedDate = picked;
  //       uploadDateController.text =
  //           "${picked.year} / ${picked.month} / ${picked.day}";
  //     });
  //     print('11111');
  //     print(uploadDateController.text);
  //   }
  // }

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
          title: "Additional Documents",
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SizedBox(
          height: size.height - statusBarHeight,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Field(
                    labelText: "Document Name",
                    isLabel: true,
                    hintText: "Enter Document Name",
                    vertical: 0.03,
                    horizontal: 0.04,
                    focusNode: docsNameFocus,
                    fieldController: docsNameController,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "Upload Date",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: uploadDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
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
                  ),
                  SizedBox(height: size.height * 0.02),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "Attachment",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  FilePickerButton(
                    onFilePicked: (file) {
                      setState(() {
                        _file = file;
                      });
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                  Visibility(
                    visible: !isLoading,
                    child: AgreeButton(
                      buttonText: "Save & Continue",
                      onPressed: () async {
                        if (_file != null &&
                            docsNameController.text.isNotEmpty) {
                          // await _saveData();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddDocument(
                                isVerifyAadhar: true,
                                isVerifyBankAccount: true,
                                isVerifyDriverLicense: true,
                                isVerifyInsurance: true,
                                isVerifyPan: true,
                                isVerifyPermanentAddress: true,
                                isVerifyPhoto: true,
                                isVerifyRC: true,
                                isVerifyVehicle: true,
                                isVerifyConsult: true,
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
                  SizedBox(height: size.height * 0.02),
                  // SizedBox(height: size.height * 0.1, child: bottomLine()),
                  // bottomLine(),
                  LayoutBuilder(builder: (context, constraints) {
                    double fontSize = constraints.maxWidth * 0.04;
                    return Text.rich(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'Upload these documents to become a Driving Partner with ',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: 'CHOLA',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
