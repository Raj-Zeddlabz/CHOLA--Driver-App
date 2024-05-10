import 'dart:io';

import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ImagePickerButton extends StatefulWidget {
  final Function(File)? onImagePicked;
  final String docsName;
  final String fileName;

  const ImagePickerButton(
      {Key? key,
      this.onImagePicked,
      required this.docsName,
      required this.fileName})
      : super(key: key);

  @override
  _ImagePickerButtonState createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File? _imageFile;
  // bool _isLoading = false;


  // Asynchronously retrieves an image from the specified source. 
  // It uses the ImagePicker plugin to pick an image with the given image quality.
  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: 10,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      if (widget.onImagePicked != null) {
        widget.onImagePicked!(_imageFile!);
      }
    }
  }

  // Future<void> uploadFile() async {
  //   if (_imageFile == null) return;
  //   final fileName = basename(_imageFile!.path);
  //   final destination =
  //       '${Constants.phoneNo}/${widget.docsName}/${widget.fileName}';

  //   try {
  //     final ref = firebase_storage.FirebaseStorage.instance
  //         .ref(destination)
  //         .child('${widget.fileName}/');
  //     await ref.putFile(_imageFile!);
  //   } catch (e) {
  //     print('error occurred');
  //   }
  // }


  // Shows an image picker dialog with text buttons for gallery and camera.
  void showImagePickerDialog(BuildContext context) {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _getImage(ImageSource.gallery);
              },
              child: Icon(
                Icons.image_rounded,
                size: size.height * 0.07,
                color: Colors.amber,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _getImage(ImageSource.camera);
              },
              child: Icon(
                Icons.camera_alt_rounded,
                size: size.height * 0.07,
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
      /**
     * Builds the widget tree for this widget based on the given [BuildContext].
     *
     * @param context the context in which the widget is being built
     * @return the widget tree for this widget
     */
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        // if (_isLoading) CircularProgressIndicator(), // Show loading indicator
        if (_imageFile != null)
          GestureDetector(
            onTap: () {
              showImagePickerDialog(context);
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
              showImagePickerDialog(context);
            },
            child: Container(
              height: size.height * 0.1,
              width: double.maxFinite,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.02,
                vertical: size.height * 0.02,
              ),
              child: Center(
                child: Text(
                  "Choose from phone/click image",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: size.shortestSide * 0.05,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class FilePickerButton extends StatefulWidget {
  final Function(File)? onFilePicked;

  const FilePickerButton({Key? key, this.onFilePicked}) : super(key: key);

  @override
  _FilePickerButtonState createState() => _FilePickerButtonState();
}

class _FilePickerButtonState extends State<FilePickerButton> {
  File? _file;

  Future<void> _getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
      });
      if (widget.onFilePicked != null) {
        widget.onFilePicked!(_file!);
      }
    }
  }

  // void showFilePickerDialog(BuildContext context) {
  //   final size = MediaQuery.of(context).size;
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       backgroundColor: Colors.transparent,
  //       title: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           TextButton(
  //             onPressed: () {
  //               _getFile();
  //               Navigator.pop(context);
  //             },
  //             child: Icon(
  //               Icons.folder_rounded,
  //               size: size.height * 0.07,
  //               color: Colors.amber,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        if (_file != null)
          GestureDetector(
            onTap: () {
              _getFile();
              // showFilePickerDialog(context);
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
              child: Text(
                path.basename(_file!.path),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: size.shortestSide * 0.05,
                ),
              ),
            ),
          ),
        if (_file == null)
          GestureDetector(
            onTap: () {
              // showFilePickerDialog(context);
              _getFile();
            },
            child: Container(
              height: size.height * 0.1,
              width: double.maxFinite,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.02,
                vertical: size.height * 0.02,
              ),
              child: Center(
                child: Text(
                  "Choose file",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: size.shortestSide * 0.05,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
