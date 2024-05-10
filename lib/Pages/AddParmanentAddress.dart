import 'dart:io';

import 'package:chola_driver_flutter/Constants/ApiCollection.dart';
import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/AddDocument.dart';
import 'package:chola_driver_flutter/Pages/MapAddress.dart';
// import 'package:chola_driver_flutter/Widgets/BackButton.dart';
import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
// import 'package:chola_driver_flutter/Widgets/DropDown.dart';
import 'package:chola_driver_flutter/Widgets/Field.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';

class ParmanentAddress extends StatefulWidget {
  const ParmanentAddress({super.key});

  @override
  State<ParmanentAddress> createState() => _ParmanentAddressState();
}

class _ParmanentAddressState extends State<ParmanentAddress> {
  TextEditingController streetController = TextEditingController();
  TextEditingController addressline2Controller = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController postalController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController houseController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _loadSavedData();
    _fetchCurrentLocation();
  }
//Load the data 
  Future<void> _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      houseController.text = prefs.getString('house') ?? '';
      apartmentController.text = prefs.getString('apartment') ?? '';
      streetController.text = prefs.getString('street') ?? '';
      addressline2Controller.text = prefs.getString('addressLine2') ?? '';
      cityController.text = prefs.getString('city') ?? '';
      stateController.text = prefs.getString('state') ?? '';
      postalController.text = prefs.getString('postal') ?? '';
      countryController.text = prefs.getString('country') ?? '';
    });
  }
//Save the data
  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('house', houseController.text);
    await prefs.setString('apartment', apartmentController.text);
    await prefs.setString('street', streetController.text);
    await prefs.setString('addressLine2', addressline2Controller.text);
    await prefs.setString('city', cityController.text);
    await prefs.setString('state', stateController.text);
    await prefs.setString('postal', postalController.text);
    await prefs.setString('country', countryController.text);
  }
    /// Fetches the current location asynchronously.
    ///
    /// This function checks if the permission to access the device's location is granted.
    /// If the permission is granted, it retrieves the current position using the `Geolocator` class.
    /// It then converts the position coordinates to a list of `Placemark` objects using the `placemarkFromCoordinates` function.
    /// The first `Placemark` object in the list is assigned to the `placemark` variable.
    ///
    /// If the `Constants.latLang` value is equal to `LatLng(0, 0)`, the function sets the text fields of various controllers with the corresponding values from the `placemark` object.
    /// Otherwise, it retrieves the placemarks using the coordinates from `Constants.latLang` and assigns the first `Placemark` object to the `placemark` variable.
    /// The text fields of the various controllers are then set with the corresponding values from the `placemark` object.
    ///
    /// If an error occurs during the fetching of the location, the error message is printed.
    /// If the permission to access the device's location is not granted, the message 'Permission not granted' is printed.
    ///
    /// This function does not take any parameters and does not return any value.
  Future<void> _fetchCurrentLocation() async {
    // Check if permission is granted
    PermissionStatus permissionStatus = await Permission.location.request();
    if (permissionStatus.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        Placemark placemark = placemarks.first;
        if (Constants.latLang == LatLng(0, 0)) {
          setState(() {
            streetController.text = placemark.street ?? '';
            cityController.text = placemark.locality ?? '';
            stateController.text = placemark.administrativeArea ?? '';
            countryController.text = placemark.country ?? '';
            addressline2Controller.text = placemark.subLocality ?? '';
            apartmentController.text = placemark.subAdministrativeArea ?? '';
            houseController.text = placemark.subThoroughfare ?? '';
            postalController.text = placemark.postalCode ?? '';
          });
        } else {
          List<Placemark> placemarks = await placemarkFromCoordinates(
              Constants.latLang.latitude, Constants.latLang.longitude);
          Placemark placemark = placemarks.first;
          setState(() {
            streetController.text = placemark.street ?? '';
            cityController.text = placemark.locality ?? '';
            stateController.text = placemark.administrativeArea ?? '';
            countryController.text = placemark.country ?? '';
            addressline2Controller.text = placemark.subLocality ?? '';
            apartmentController.text = placemark.subAdministrativeArea ?? '';
            houseController.text = placemark.subThoroughfare ?? '';
            postalController.text = placemark.postalCode ?? '';
          });
        }
      } catch (e) {
        print('Error fetching location: $e');
      }
    } else {
      // Handle case when permission is not granted
      print('Permission not granted');
    }
  }

  // Future<void> _fetchCurrentLocation() async {
  //   try {
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     List<Placemark> placemarks =
  //         await placemarkFromCoordinates(position.latitude, position.longitude);
  //     Placemark placemark = placemarks.first;
  //     if (Constants.latLang == LatLng(0, 0)) {
  //       setState(() {
  //         streetController.text = placemark.street ?? '';
  //         cityController.text = placemark.locality ?? '';
  //         stateController.text = placemark.administrativeArea ?? '';
  //         countryController.text = placemark.country ?? '';
  //         // countryCodeController.text = placemark.countryCode ?? '';
  //         addressline2Controller.text = placemark.subLocality ?? '';
  //         apartmentController.text = placemark.subAdministrativeArea ?? '';
  //         houseController.text = placemark.subThoroughfare ?? '';
  //         postalController.text = placemark.postalCode ?? '';

  //         // Update other fields as needed
  //       });
  //     } else {
  //       List<Placemark> placemarks = await placemarkFromCoordinates(
  //           Constants.latLang.latitude, Constants.latLang.longitude);
  //       Placemark placemark = placemarks.first;
  //       setState(() {
  //         streetController.text = placemark.street ?? '';
  //         cityController.text = placemark.locality ?? '';
  //         stateController.text = placemark.administrativeArea ?? '';
  //         countryController.text = placemark.country ?? '';
  //         // countryCodeController.text = placemark.countryCode ?? '';
  //         addressline2Controller.text = placemark.subLocality ?? '';
  //         apartmentController.text = placemark.subAdministrativeArea ?? '';
  //         houseController.text = placemark.subThoroughfare ?? '';
  //         postalController.text = placemark.postalCode ?? '';
  //         // Update other fields as needed
  //       });
  //     }
  //   } catch (e) {
  //     print('Error fetching location: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var statusBarHeight = MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(
        top: statusBarHeight,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: CustomAppBar(
          preferredHeight: size.height * 0.08,
          title: 'Residence Address',
        ),
        body: SizedBox(
          height: size.height - statusBarHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02,
              vertical: size.height * 0.02,
            ),
            child: Center(
              child: Container(
                width: size.width,
                height: size.height * 0.75,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.02,
                                      vertical: size.height * 0.01,
                                    ),
                                    child: Text(
                                      'House No.',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: size.shortestSide * 0.045,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Field(
                                    labelText: "",
                                    hintText: "Enter Your House Number",
                                    vertical: 0.03,
                                    horizontal: 0.04,
                                    snackbarText: '* Required',
                                    fieldController: houseController,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: size.width * 0.02),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.02,
                                      vertical: size.height * 0.01,
                                    ),
                                    child: Text(
                                      'Apartment, Suit, etc..',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: size.shortestSide * 0.045,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Field(
                                    labelText: "",
                                    hintText: "Enter Your Apartment Name",
                                    vertical: 0.03,
                                    horizontal: 0.03,
                                    // snackbarText: '* Required',
                                    fieldController: apartmentController,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02,
                                vertical: size.height * 0.01,
                              ),
                              child: Text(
                                'Street/Address Line 1',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: size.shortestSide * 0.045,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Field(
                          labelText: "",
                          hintText: "Enter Name of Street",
                          vertical: 0.03,
                          horizontal: 0.04,
                          snackbarText: '* Required',
                          suffixWidget: IconButton(
                            onPressed: () {
                              //Navigate to Map page for address input
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapAddress(),
                                ),
                              );
                            },
                            icon: Icon(Icons.location_on),
                            color: Color(0xff473CC5),
                          ),
                          fieldController: streetController,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02,
                                vertical: size.height * 0.01,
                              ),
                              child: Text(
                                'Address Line 2', //Make it Optional
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: size.shortestSide * 0.045,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Field(
                          labelText: "",
                          hintText: "Enter Your Address Line 2",
                          vertical: 0.03,
                          horizontal: 0.03,
                          // snackbarText: '* Required',
                          fieldController: addressline2Controller,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02,
                                vertical: size.height * 0.01,
                              ),
                              child: Text(
                                'City',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: size.shortestSide * 0.045,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Field(
                          labelText: "",
                          hintText: "Enter Your City",
                          vertical: 0.03,
                          horizontal: 0.03,
                          snackbarText: '* Required',
                          fieldController: cityController,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02,
                                vertical: size.height * 0.01,
                              ),
                              child: Text(
                                'State',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: size.shortestSide * 0.045,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Field(
                          labelText: "",
                          hintText: "Enter Your State",
                          vertical: 0.03,
                          horizontal: 0.03,
                          snackbarText: '* Required',
                          fieldController: stateController,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02,
                                vertical: size.height * 0.01,
                              ),
                              child: Text(
                                'Postal Code',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: size.shortestSide * 0.045,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Field(
                          labelText: "",
                          hintText: "Enter Your Postal Code",
                          vertical: 0.03,
                          horizontal: 0.03,
                          snackbarText: '* Required',
                          keyboardType: TextInputType.number,
                          fieldController: postalController,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02,
                                vertical: size.height * 0.01,
                              ),
                              child: Text(
                                'Country',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: size.shortestSide * 0.045,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Field(
                          labelText: "",
                          hintText: "Enter Your Country",
                          vertical: 0.03,
                          horizontal: 0.03,
                          snackbarText: '* Required',
                          fieldController: countryController,
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: size.height * 0.1,
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03,
                vertical: size.height * 0.02,
              ),
              child: AgreeButton(
                buttonText: "Save & Continue",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Map<String, dynamic> result =
                    //     await ApiCollection.updateResidenceAddress(
                    //   houseController.text,
                    //   apartmentController.text,
                    //   streetController.text,
                    //   addressline2Controller.text,
                    //   cityController.text,
                    //   stateController.text,
                    //   countryController.text,
                    //   postalController.text,
                    // );
                    // setState(() {
                    //   Constants.documents_data = result;
                    // });
                    // Directory appDocDir = await getApplicationCacheDirectory();
                    // String appDocPath = appDocDir.path;

                    // // Create a "Permanent Address" folder if it doesn't exist
                    // String permanentAddressFolderPath = '$appDocPath/Documents';
                    // Directory(permanentAddressFolderPath)
                    //     .createSync(recursive: true);
                    // print(permanentAddressFolderPath);
                    // // Store the address information in a file inside the folder
                    // File addressFile =
                    //     File('$permanentAddressFolderPath/address.txt');
                    // await addressFile
                    //     .writeAsString('House No: ${houseController.text}\n'
                    //         'Apartment: ${apartmentController.text}\n'
                    //         'Street: ${streetController.text}\n'
                    //         'Address Line 2: ${addressline2Controller.text}\n'
                    //         'City: ${cityController.text}\n'
                    //         'State: ${stateController.text}\n'
                    //         'Country: ${countryController.text}');

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddDocument(
                          isVerifyPermanentAddress: true,
                        ),
                      ),
                    );
                  }
                },
                padding: 0.8,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _saveData(); // Save data when the widget is disposed
    super.dispose();
  }
}
