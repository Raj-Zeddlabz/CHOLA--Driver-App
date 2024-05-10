import 'dart:async';
import 'dart:io';

import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Constants/colors_pallete.dart';
import 'package:chola_driver_flutter/Controllers/map_controller.dart';
import 'package:chola_driver_flutter/Pages/Earning.dart';
// import 'package:chola_driver_flutter/Pages/Earning.dart';
import 'package:chola_driver_flutter/Pages/Service.dart';
import 'package:chola_driver_flutter/Pages/customer_service.dart';
import 'package:chola_driver_flutter/Services/online_driver_api.dart';
import 'package:chola_driver_flutter/Widgets/CustomMenuButton.dart';
import 'package:chola_driver_flutter/Widgets/Menu.dart';
import 'package:chola_driver_flutter/Widgets/bottom_sheet/bottom_sheet.dart';

import 'package:chola_driver_flutter/Widgets/ride_appbar/home_appbar.dart';
import 'package:chola_driver_flutter/secret/secrets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:upgrader/upgrader.dart';

class HomePage extends StatefulWidget {
  // final String jwt;

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MapController mapController = Get.put(MapController());

  late GoogleMapController _controller;
  // Position? currentPosition;
  PanelController? _panelController;
  // bool isOnline = false;

  static const LatLng staticDestination = LatLng(16.77115, 74.55116);

  StreamSubscription<Position>? _positionStream;
  Marker _userMarker = Marker(
    markerId: MarkerId("currentLocation"),
    infoWindow: InfoWindow(title: "Current Location", snippet: "You are here"),
  );

  @override
  void initState() {
    super.initState();
    _initMap(context);
    _panelController = PanelController();
    _startLocationUpdates();
  }

  // @override
  // void didChangeDependencies() {
  //   _positionStream?.cancel();
  //   super.didChangeDependencies();
  //   super.dispose();
  // }

  @override
  void dispose() {
    _positionStream?.cancel();
    // _panelController?.dispose();

    super.dispose(); // Always call super.dispose() at the end
  }

  /// Initializes the map by requesting location permission and getting the current location.
  ///
  /// This function is asynchronous and returns a `Future<void>`. It first calls the `_requestLocationPermission` function to request location permission. Then, it calls the `_getCurrentLocation` function to get the current location. If any error occurs during this process, it prints the error message and shows a snackbar with the message "Please connect to the Internet."
  ///
  /// This function does not take any parameters.
  ///
  /// This function does not return any value.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// await _initMap();
  /// ```
  ///
  Future<void> _initMap(BuildContext context) async {
    try {
      await _requestLocationPermission();
      await _getCurrentLocation();
    } catch (e) {
      print("Error initializing map: $e");
      // Handle the error here, for example, show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Please connect to the Internet and allow Location Permission'),
        ),
      );
    }
  }

  // Requests location permission asynchronously.
  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      await Permission.location.request();
    }
  }

  /// Retrieves the current location asynchronously.
  ///
  /// This function requests the user's permission to access the device's location and retrieves the current position.
  /// The desired accuracy of the location is set to high.
  /// If successful, the current position is stored in the `currentPosition` variable.
  /// If an error occurs, an error message is printed and a dialog is shown to the user with the error details.
  /// The dialog contains a title "Connection Error" and a message "Please connect to the Internet."
  /// The dialog also contains an "OK" button that closes the dialog.
  ///
  /// This function does not take any parameters.
  ///
  /// This function does not return any value.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// await _getCurrentLocation();
  /// ```
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        mapController.currentPosition = position;
      });
    } catch (e) {
      print("Error getting current location: $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Connection Error',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            content: Text(
              'Please connect to the Internet.',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // Navigator.of(context).pop();
                  // Get.back();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  List<LatLng> polyLineCoordinates = [
    LatLng(16.78377, 74.55479),
    LatLng(16.78365, 74.55453),
    LatLng(16.78324, 74.55476),
    LatLng(16.78256, 74.55507),
    LatLng(16.78144, 74.55561),
    LatLng(16.77992, 74.55633),
    LatLng(16.77927, 74.55541),
    LatLng(16.77867, 74.55447),
    LatLng(16.77801, 74.55329),
    LatLng(16.7775, 74.55248),
    LatLng(16.77687, 74.55135),
    LatLng(16.77645, 74.55055),
    LatLng(16.7758, 74.54862),
    LatLng(16.77504, 74.54887),
    LatLng(16.77461, 74.54899),
    LatLng(16.77443, 74.54903),
    LatLng(16.77428, 74.54904),
    LatLng(16.77389, 74.54905),
    LatLng(16.77358, 74.54913),
    LatLng(16.77378, 74.55019),
    LatLng(16.77384, 74.55053),
    LatLng(16.77359, 74.55057),
    LatLng(16.77292, 74.55071),
    LatLng(16.77247, 74.5508),
    LatLng(16.77228, 74.55093),
    LatLng(16.77168, 74.55104),
    LatLng(16.77115, 74.55116)
  ];

  void getPolyPoints() async {
    polyLineCoordinates.clear(); // Clear previous points
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Secrets.GOOGLE_MAP_API_KEY,
        PointLatLng(mapController.currentPosition!.latitude,
            mapController.currentPosition!.longitude),
        PointLatLng(staticDestination.latitude, staticDestination.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {}); // Update the map
    }
  }

  /// Moves the camera to the current location if the current position and the controller are not null.
  ///
  /// This function takes no parameters and returns no value. It uses the `_controller` to animate the camera to the current position, which is obtained from the `currentPosition` variable. If either the `currentPosition` or the `_controller` is null, the function does nothing.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// _moveToCurrentLocation();
  /// ```
  void _moveToCurrentLocation() {
    if (mapController.currentPosition != null && _controller != null) {
      _controller.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(
            mapController.currentPosition!.latitude,
            mapController.currentPosition!.longitude,
          ),
        ),
      );
    }
  }

  Future<void> _startLocationUpdates() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    _positionStream =
        Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        mapController.currentPosition = position;
        _userMarker = _userMarker.copyWith(
          positionParam: LatLng(position.latitude, position.longitude),
        );
      });
    });
  }

  // void updateCurrentLocationString(LatLng? tappedPoint, bool isFrom) async {
  //   tappedPoint: currentPosition != null
  //       ? LatLng(currentPosition!.latitude, currentPosition!.longitude)
  //       : null;
  //   if (tappedPoint == null) return;
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //         tappedPoint.latitude, tappedPoint.longitude);

  //     String locality = placemarks[0].locality ?? '';
  //     String subLocality = placemarks[0].subLocality ?? '';
  //     String administrativeArea = placemarks[0].administrativeArea ?? '';
  //     String subAdministrativeArea = placemarks[0].subAdministrativeArea ?? '';
  //     String postalCode = placemarks[0].postalCode ?? '';
  //     String country = placemarks[0].country ?? '';
  //     String name = placemarks[0].name ?? '';
  //     String street = placemarks[0].street ?? '';
  //     final full_address =
  //         '$subLocality $locality, $administrativeArea, $postalCode, $country';
  //     print("Full Address: $full_address");
  //     print("name: $name, $subAdministrativeArea, $street");

  //     // update();
  //   } catch (e) {
  //     print("Error getting placemarks: $e");
  //   }
  // }

  /// Builds the widget for the current build context.
  ///
  /// The `build` method takes a `BuildContext` object as a parameter
  /// and returns a `Widget`. It is responsible for constructing and
  /// returning the widget that represents the current state of the widget tree.
  ///
  /// The `build` method first retrieves the size of the media
  /// query using `MediaQuery.of(context).size`.
  ///  It then creates an `UpgradeAlert` widget, which displays an upgrade dialog to the user.
  /// The `dialogStyle` property of the `UpgradeAlert` widget is set based on the platform the app is running on.
  /// If the platform is iOS, the `dialogStyle` is set to `UpgradeDialogStyle.cupertino`, otherwise it is set to `UpgradeDialogStyle.material`.
  /// The `showIgnore`, `showReleaseNotes`, and `showLater` properties of the `UpgradeAlert` widget are all set to `false`.
  ///
  /// The `upgrader` property of the `UpgradeAlert` widget is set to an instance
  /// of the `Upgrader` class, which is responsible for handling the upgrade logic.
  /// The `messages` property of the `Upgrader` class is set to an instance of the `UpgraderMessages` class,
  ///  which contains the messages displayed in the upgrade dialog.
  /// The `code` property of the `UpgraderMessages` class is set to a string message informing the user that a new version of the app is available
  /// and they should update to continue using the app.
  /// The `languageCode` property of the `Upgrader` class is set to `'en'` to indicate that the messages should be displayed in English.
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return UpgradeAlert(
      dialogStyle: (Platform.isIOS)
          ? UpgradeDialogStyle.cupertino
          : UpgradeDialogStyle.material,
      showIgnore: false,
      showReleaseNotes: false,
      showLater: false,
      upgrader: Upgrader(
        messages: UpgraderMessages(
          code:
              'A new version of the app is available. Please update to continue using the app.',
        ),
        languageCode: 'en',
      ),
      onUpdate: () {
        // Handle update action
        Constants.navigateToUrl();
        return false; // Return false to close the dialog
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Scaffold(
          appBar: HomeAppBar(
            preferredHeight: 100.h,
            title: "",
          ),
          body: PopScope(
            canPop: false,
            child: Stack(
              children: [
                if (mapController.currentPosition != null)
                  GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                    },
                    initialCameraPosition: CameraPosition(
                      zoom: 15.0,
                      target: LatLng(
                        mapController.currentPosition!.latitude,
                        mapController.currentPosition!.longitude,
                      ),
                    ),
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      ),
                    },
                    markers: {
                      _userMarker,
                    },
                  ),
                if (mapController.currentPosition == null)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: IconButton(
                        onPressed: () {
                          Constants.showError(context,
                              "Stay Tuned for an Exciting Addition! We're thrilled to announce a new feature coming your way!");
                        },
                        icon: Icon(
                          Icons.privacy_tip,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: IconButton(
                        onPressed: _moveToCurrentLocation,
                        icon: Icon(
                          Icons.my_location,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Transform.scale(
                      scale: 1.8,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 5.5,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Obx(
                                () => FlutterSwitch(
                                    height: 30.w,
                                    activeToggleColor: Colors.green,
                                    activeColor: Colors.white,
                                    inactiveColor: Colors.white,
                                    inactiveToggleColor: Colors.red,
                                    toggleColor: Colors.green,
                                    activeTextColor: Colors.green,
                                    inactiveTextColor: Colors.red,
                                    activeText: 'online,',
                                    inactiveText: 'offline',
                                    activeSwitchBorder: Border.all(
                                        color: Colors.green,
                                        width: 1.7,
                                        style: BorderStyle.solid),
                                    inactiveSwitchBorder: Border.all(
                                        color: Colors.red, width: 1.7),
                                    activeTextFontWeight: FontWeight.bold,
                                    inactiveTextFontWeight: FontWeight.bold,
                                    valueFontSize: 30.sp,
                                    toggleSize: 25.w,
                                    value: mapController.isOnline.value,
                                    onToggle: (value) {
                                      mapController.updateOnlineStatus(value);
                                      setState(() {});
                                      if (mapController.isOnline.value &&
                                          mapController.currentPosition !=
                                              null) {
                                        getPolyPoints();
                                        if (mapController.isOnline.value) {
                                          showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            barrierColor: Colors.transparent,
                                            isScrollControlled: true,
                                            enableDrag: false,
                                            elevation: 0,
                                            isDismissible: false,
                                            context: context,
                                            builder: (context) =>
                                                BottomSheetWidget(
                                              passcurrentPosition: mapController
                                                          .currentPosition !=
                                                      null
                                                  ? LatLng(
                                                      mapController
                                                          .currentPosition!
                                                          .latitude,
                                                      mapController
                                                          .currentPosition!
                                                          .longitude)
                                                  : null, // Create LatLng from Position
                                              title: 'Solo Ride',
                                            ),
                                          );
                                        }
                                      } else {
                                        polyLineCoordinates.clear();
                                      }
                                    }),
                              ),
                            ),
                          ),
                          Positioned(
                            // Align the text precisely within the switch bounds
                            top: 0.0, // Adjust these values as needed
                            bottom: 0.0,
                            left: Constants.switchValue ? -28 : 20,
                            right: 0.0,
                            child: Center(
                              child: Text(
                                Constants.switchValue ? 'Online' : 'Offline',
                                style: TextStyle(
                                  color: Constants.switchValue
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ),
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
    );
  }
}
