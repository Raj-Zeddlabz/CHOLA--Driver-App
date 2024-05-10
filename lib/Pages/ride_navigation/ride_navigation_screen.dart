import 'dart:async';
import 'package:chola_driver_flutter/Constants/colors_pallete.dart';
import 'package:chola_driver_flutter/Constants/custom_icons.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
import 'package:chola_driver_flutter/Widgets/bottom_sheet/bottom_sheet_otp.dart';
import 'package:chola_driver_flutter/Widgets/snackbar.dart';
import 'package:chola_driver_flutter/secret/secrets.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideNavigationScreen extends StatefulWidget {
  final LatLng? passcurrentPosition;
  const RideNavigationScreen({super.key, this.passcurrentPosition});

  @override
  State<RideNavigationScreen> createState() => _RideNavigationScreenState();
}

class _RideNavigationScreenState extends State<RideNavigationScreen> {
  int _currentStep = 0;
  static const LatLng staticDestination = LatLng(16.77115, 74.55116);
  Completer<GoogleMapController> _controller = Completer();

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

  Future<void> _calculatePolyline() async {
    polyLineCoordinates.clear();
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Secrets.GOOGLE_MAP_API_KEY, // Replace with your actual API key
      PointLatLng(widget.passcurrentPosition!.latitude,
          widget.passcurrentPosition!.longitude),
      PointLatLng(staticDestination.latitude, staticDestination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {});
    }
  }

  Future<BitmapDescriptor> getCarIcon() async {
    return BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)), // Adjust size as needed
      'assets/svg/navigation.svg',
    );
  }

  @override
  void initState() {
    super.initState();
    // getPolyPoints();
     // Start
  }
  


  @override
  Widget build(BuildContext context) {
    final CameraPosition _kGoogle = CameraPosition(
      // target: controller.pickUpLocation!,
      target: LatLng(16.78377, 74.55479),

      zoom: 14,
    );
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          preferredHeight: MediaQuery.of(context).size.height * 0.095,
          title: 'Right on next road',
          onPressed: () {},
        ),
        body: Column(
          children: [
            Expanded(
              flex: 10,
              child: GoogleMap(
                //given camera position
                mapToolbarEnabled: true,
                initialCameraPosition: _kGoogle,
                mapType: MapType.terrain,
                // specified set of markers below
                markers: {
                  Marker(
                    markerId: MarkerId("Source"),
                    position: widget.passcurrentPosition ?? LatLng(0, 0),
                    // icon: await getCarIcon(), /
                  ),
                  Marker(
                      markerId: MarkerId("Destination"),
                      // position: controller.destinationLocation!)
                      position: LatLng(16.77115, 74.55116)),
                },
                // on below line we have enabled location
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                // on below line we have enabled compass location
                compassEnabled: true,
                // on below line we have added polylines
                polylines: {
                  Polyline(
                      polylineId: PolylineId("route"),
                      width: 8,
                      color: Color(0xFF2E50CF),
                      points: polyLineCoordinates),
                },
                // displayed google map
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  // height: 450.h,
                  decoration: BoxDecoration(
                      color: ColorsPallete.mainbg,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15.r))),
                  // color: Colors.red,
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.keyboard_arrow_up,
                        size: 50.sp,
                      ),
                      SizedBox(
                        width: 40.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "8 min 1.2 KM",
                            style: TextStyle(
                                fontSize: 24.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Dropping off Raj",
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: MediaQuery.of(context).size.width * 0.08,
          fixedColor: Color(0xff454545),
          unselectedItemColor: Color(0xff454545),
          backgroundColor: Color(0xFFCFD6FF),
          elevation: MediaQuery.of(context).size.width * 0.7,
          useLegacyColorScheme: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.call),
              label: 'Call Driver',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_rounded),
              label: 'Text Driver',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cancel_presentation),
              label: 'Cancle Ride',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.support_agent_outlined),
              label: 'Support',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
          ],
          onTap: (value) {},
        ),
      ),
    );
  }
}
