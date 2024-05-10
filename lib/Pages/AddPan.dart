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

class PanCard extends StatefulWidget {
  const PanCard({
    Key? key,
  }) : super(key: key);

  @override
  State<PanCard> createState() => _PanCardState();
}

class _PanCardState extends State<PanCard> {
  TextEditingController panCardController = TextEditingController();
  bool isVerify = false;
  File? _frontImageFile;
  File? _backImageFile;
  String frontImageUrl = '';
  String backImageUrl = '';
  FocusNode _panFocus = FocusNode();
  late SharedPreferences _prefs;
  bool isLoading = false;

  // Add a GlobalKey for the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _panFocus.requestFocus();
    _loadData();
  }

  @override
  void dispose() {
    _panFocus.dispose();
    super.dispose();
  }
//load the data
  Future<void> _loadData() async {
    _prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        panCardController.text = _prefs.getString('panCard') ?? '';

        // Load front and back image URLs
        String? frontImageUrl = _prefs.getString('PANCardFrontUrl');
        String? backImageUrl = _prefs.getString('PANCardBackUrl');
        _frontImageFile = frontImageUrl != null ? File(frontImageUrl) : null;
        _backImageFile = backImageUrl != null ? File(backImageUrl) : null;
      });
    }
  }
// save the data
  Future<void> _saveData() async {
    setState(() {
      isLoading = true;
    });
    await _prefs.setString('panCard', panCardController.text);
    if (_frontImageFile != null) {
      frontImageUrl =
          await uploadFile(_frontImageFile!, 'PANCard', 'PANCardFront');
      if (mounted) {
        await _prefs.setString('PANCardFrontUrl', frontImageUrl);
      }
    }
    if (_backImageFile != null) {
      backImageUrl =
          await uploadFile(_backImageFile!, 'PANCard', 'PANCardBack');
      if (mounted) {
        await _prefs.setString('PANCardBackUrl', backImageUrl);
      }
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }
//upload file
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(
        top: statusBarHeight,
      ),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          preferredHeight: size.height * 0.08,
          title: "Pan Card",
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
              child: Column(
                children: [
                  Image.asset(
                    'assets/Pan.png',
                    width: double.maxFinite,
                  ),
                  Text(
                    'Add Your Pan Card',
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
                      focusNode: _panFocus,
                      hintText: "Enter Your Pan Number",
                      vertical: 0.04,
                      horizontal: 0.04,
                      maxLength: 10,
                      keyboardType: TextInputType.text,
                      fieldController: panCardController,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    'PAN Card Front',
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
                      docsName: 'PANCard',
                      fileName: 'PANCardFront',
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
                    'PAN Card Back',
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
                      docsName: 'PANCard',
                      fileName: 'PANCardBack',
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
                                if (panCardController.text.length != 10) {
                                  Constants.showError(
                                    context,
                                    "Please enter a valid PAN number. \nPAN numbers in India are 10 characters long.",
                                  );
                                } else if (_frontImageFile == null) {
                                  Constants.showError(
                                    context,
                                    "Please Attach/Take Picture of Front side of PAN Card",
                                  );
                                } else if (_backImageFile == null) {
                                  Constants.showError(
                                    context,
                                    "Please Attach/Take Picture of Back side of PAN Card",
                                  );
                                } else {
                                  setState(() {
                                    isVerify = true;
                                  });
                                  await _saveData();
                                  // await ApiCollection.updatePanCard(
                                  //   panCardController.text,
                                  //   frontImageUrl,
                                  //   backImageUrl,
                                  // );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddDocument(
                                        isVerifyPermanentAddress: true,
                                        isVerifyAadhar: isVerify,
                                        isVerifyPan: isVerify,
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
                          bottomLine(),
                        ],
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
