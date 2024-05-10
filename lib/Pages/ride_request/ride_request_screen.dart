import 'package:chola_driver_flutter/Widgets/ride_appbar/home_appbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RideRequestScreen extends StatefulWidget {
  const RideRequestScreen({super.key});

  @override
  State<RideRequestScreen> createState() => _RideRequestScreenState();
}

class _RideRequestScreenState extends State<RideRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        preferredHeight: 100.h,
        title: "",
      ),
      body: SingleChildScrollView(
        // Allow content to scroll if necessary
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Adjust padding as needed
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align content to left
            children: [
              // Origin and Destination Information (replace with actual data)
              Text(
                'Origin: Near Hanuman Mandir',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Text(
                'Destination: Near Rajpath',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),

              // Additional Details (fare, estimated time, etc.)
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'INR 1000.00',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '4 Min (0.2km away)',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                ],
              ),

              // Ride Acceptance Buttons
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle ride acceptance logic (API call, navigation, etc.)
                      print('Ride accepted!'); // Placeholder for actual action
                    },
                    child: Text('Accept'),
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(120.w, 50.h), // Adjust button size as needed
                      // primary: Colors.green,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle ride decline logic (optional)
                      print(
                          'Ride declined!'); // Placeholder for actual action (optional)
                    },
                    child: Text('Decline'),
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(120.w, 50.h), // Adjust button size as needed
                      // primary: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
