import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/AddParmanentAddress.dart';
import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapAddress extends StatefulWidget {
  const MapAddress({Key? key}) : super(key: key);

  @override
  State<MapAddress> createState() => _MapAddressState();
}

class _MapAddressState extends State<MapAddress> {
  late GoogleMapController mapController;
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
  }
    /// Fetches the current location asynchronously.
    ///
    /// This function requests the user's permission to access the device's location and retrieves the current position.
    /// The desired accuracy of the location is set to high.
    /// If successful, the current position is stored in the `_currentLocation` variable.
    /// If an error occurs, an error message is printed.
    ///
    /// This function does not take any parameters.
    ///
    /// This function does not return any value.
    ///
    /// Example usage:
    ///
    /// ```dart
    /// await _fetchCurrentLocation();
    /// ```
  Future<void> _fetchCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print('Error fetching location: $e');
    }
  }
 /// Updates the position of the marker on the map.
  ///
  /// Takes a `LatLng` object `newPosition` as input and updates the `_currentLocation` state variable with the new position.
  /// This function also prints the current location to the console.
  ///
  /// Parameters:
  /// - `newPosition`: The new position of the marker.
  ///
  /// Returns: None.
  void _updateMarkerPosition(LatLng newPosition) {
    setState(() {
      _currentLocation = newPosition;
    });
    print(_currentLocation);
  }
  /// Builds the widget tree for the current screen.
  ///
  /// The [build] method is responsible for constructing the visual representation of the screen.
  /// It takes a [BuildContext] object as a parameter, which is used to access the current build context.
  /// The method returns a [Widget] that represents the screen's UI.
  ///
  /// Returns:
  /// - A [Padding] widget that wraps the screen's content.
  ///
  /// The [Padding] widget has the following properties:
  /// - `padding`: An [EdgeInsets] object that sets the padding around the content.
  /// - `child`: A [Scaffold] widget that represents the screen's layout.
  ///
  /// The [Scaffold] widget has the following properties:
  /// - `appBar`: A [CustomAppBar] widget that represents the screen's app bar.
  /// - `body`: A conditional widget that displays either a [Stack] or a [Center] widget.
  ///
  /// If `_currentLocation` is not null, the [Stack] widget is displayed. It contains the following children:
  /// - A [GoogleMap] widget that displays the map.
  /// - An [Align] widget that centers an [Image] widget.
  /// - An [Align] widget that positions a [Padding] widget at the bottom center.
  ///
  /// The [GoogleMap] widget has the following properties:
  /// - `initialCameraPosition`: A [CameraPosition] object that sets the initial camera position.
  /// - `myLocationEnabled`: A boolean value that enables the "My Location" button.
  /// - `myLocationButtonEnabled`: A boolean value that enables the "My Location" button.
  /// - `zoomControlsEnabled`: A boolean value that enables the zoom controls.
  /// - `gestureRecognizers`: A map of gesture recognizers.
  /// - `onCameraMove`: A callback function that is called when the camera moves.
  /// - `onMapCreated`: A callback function that is called when the map is created.
  ///
  /// The [Align] widget with the [Image] child centers the image on the map.
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
          title: 'Residence Address',
          preferredHeight: size.height * 0.08,
        ),
        body: _currentLocation != null
            ? Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _currentLocation!,
                      zoom: 14.47,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer()),
                    },
                    onCameraMove: (CameraPosition? position) {
                      if (_currentLocation != position!.target) {
                        _updateMarkerPosition(position.target);
                      }
                    },
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    },
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/pin.png',
                      width: size.width * 0.1,
                      height: size.width * 0.1,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AgreeButton(
                        buttonText: 'Continue',
                        onPressed: () {
                          setState(() {
                            Constants.latLang = _currentLocation!;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ParmanentAddress(),
                            ),
                          );
                        },
                        padding: 0.6,
                      ),
                    ),
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                  color: Color(0xff6A4DE8),
                  backgroundColor: Colors.transparent,
                ),
              ),
      ),
    );
  }
}
