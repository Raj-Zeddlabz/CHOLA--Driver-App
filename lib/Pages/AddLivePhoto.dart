import 'dart:io';

import 'package:chola_driver_flutter/Constants/ApiCollection.dart';
import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/AddDocument.dart';
import 'package:chola_driver_flutter/Widgets/BottomLine.dart';
import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class LivePhoto extends StatefulWidget {
  const LivePhoto({Key? key});

  @override
  State<LivePhoto> createState() => _LivePhotoState();
}

class _LivePhotoState extends State<LivePhoto> {
  File? _imageFile;
  late SharedPreferences _prefs;
  bool isLoading = false;
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }
//Load data
  Future<void> _loadData() async {
    _prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        // Load front and back image URLs
        String? liveImageUrl = _prefs.getString('LivePhotoUrl');
        print(liveImageUrl);

        // if (liveImageUrl != null) {
        //   _imageFile = File(liveImageUrl.toString());
        // }
      });
    }
  }
  //save data

  Future<void> _saveData() async {
    setState(() {
      isLoading = true;
    });
    if (_imageFile != null) {
      imageUrl = await uploadFile(_imageFile!, 'LivePhoto', 'LivePhoto');
      if (mounted) {
        await _prefs.setString('LivePhotoUrl', imageUrl);
        // _imageFile = File(frontImageUrl); // Store the downloaded image locally
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
      File _imageFile, String docsName, String fileName) async {
    final destination = '${Constants.phoneNo}/${docsName}/${fileName}.jpg';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('${fileName}.jpg');
      await ref.putFile(_imageFile);
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('error occurred');
      return '';
    }
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: 10,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
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
          title: "Live Photo",
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.02,
                    ),
                    child: Image.asset(
                      'assets/LivePhoto.png',
                      // width: double.maxFinite,
                    ),
                  ),
                  Text(
                    'Add Your Live Photo Here',
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
                    height: size.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                    ),
                    child: Column(
                      children: [
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
                        if (_imageFile != null)
                          GestureDetector(
                            onTap: () {
                              _getImage(ImageSource.camera);
                            },
                            child: Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                                color: Colors.white,
                              ),
                              child: Image.file(
                                _imageFile!,
                                width: size.width * 0.8,
                                height: size.height * 0.3,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        if (_imageFile == null)
                          GestureDetector(
                            onTap: () {
                              _getImage(ImageSource.camera);
                            },
                            child: Container(
                              height: size.height * 0.1,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02,
                                vertical: size.height * 0.02,
                              ),
                              child: Center(
                                child: Text(
                                  "Click image",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.shortestSide * 0.05,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.018,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: size.height * 0.15,
                      child: Center(
                        child: Column(
                          children: [
                            Visibility(
                              visible: !isLoading,
                              child: AgreeButton(
                                buttonText: "Save & Continue",
                                onPressed: () async {
                                  if (_imageFile == null) {
                                    Constants.showError(context,
                                        "Please Attach/Take a Live Photo");
                                  } else {
                                    await _saveData();
                                    // await ApiCollection.updateLivePhoto(
                                    //     imageUrl);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddDocument(
                                          isVerifyPermanentAddress: true,
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
