import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/Earning.dart';
import 'package:chola_driver_flutter/Pages/HomePage.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
import 'package:chola_driver_flutter/Widgets/ServiceListTile.dart';
import 'package:flutter/material.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  ///This is a Flutter widget that represents a page for selecting different types of rides.
  ///It uses a Scaffold widget to create a page with an app bar,
  ///a body that contains a list of ServiceListTile widgets, and a bottom navigation bar.
  ///The ServiceListTile widgets are used to display different types of rides with a checkbox to select them.
  ///The page also has a text at the bottom that explains how to receive ride requests.
  ///The page uses stateful widgets and the setState method to update the selected ride types when the user changes the checkboxes.
  ///The bottom navigation bar allows the user to navigate to different pages using the Navigator widget.
  @override
  Widget build(BuildContext context) {
    bool soloRide = false;
    bool groupRide = false;
    bool corporateRide = false;
    bool schoolRide = false;
    bool rentalRide = false;
    bool reserveRide = false;
    bool packageRide = false;
    bool intercityRide = false;

    var size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(
        top: statusBarHeight,
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Services",
          preferredHeight: size.height * 0.08,
          onPressed: () {},
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: PopScope(
          // onWillPop: () async {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => HomePage(),
          //     ),
          //   );
          //   return false;
          // },
          child: SizedBox(
            height: size.height - statusBarHeight,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ServiceListTile(
                    title: " Solo Rides",
                    value: soloRide,
                    onChanged: (value) {
                      // setState(() {
                      //   soloRide = value;
                      // });
                    },
                    imagePath: 'assets/SoloRide.png',
                  ),
                  Divider(
                    color: Color(0xffAFAFAF),
                  ),
                  ServiceListTile(
                    title: "Group Rides",
                    value: groupRide,
                    onChanged: (value) {},
                    imagePath: 'assets/Frame.png',
                  ),
                  Divider(
                    color: Color(0xffAFAFAF),
                  ),
                  ServiceListTile(
                    title: "Corporate Rides",
                    value: corporateRide,
                    onChanged: (value) {
                      // setState(() {
                      //   corporateRide = value;
                      // });
                    },
                    imagePath: 'assets/Night.png',
                  ),
                  Divider(
                    color: Color(0xffAFAFAF),
                  ),
                  ServiceListTile(
                    title: "School Rides",
                    value: schoolRide,
                    onChanged: (value) {
                      // setState(() {
                      //   schoolRide = value;
                      // });
                    },
                    imagePath: 'assets/SchoolRide.png',
                  ),
                  Divider(
                    color: Color(0xffAFAFAF),
                  ),
                  ServiceListTile(
                    title: " Rental Rides",
                    value: rentalRide,
                    onChanged: (value) {
                      // setState(() {
                      //   rentalRide = value;
                      // });
                    },
                    imagePath: 'assets/SoloRide.png',
                  ),
                  Divider(
                    color: Color(0xffAFAFAF),
                  ),
                  ServiceListTile(
                    title: "Reserve Rides",
                    value: reserveRide,
                    onChanged: (value) {
                      // setState(() {
                      //   reserveRide = value;
                      // });
                    },
                    imagePath: 'assets/Frame.png',
                  ),
                  Divider(
                    color: Color(0xffAFAFAF),
                  ),
                  ServiceListTile(
                    title: "Package Rides",
                    value: packageRide,
                    onChanged: (value) {
                      // setState(() {
                      //   packageRide = value;
                      // });
                    },
                    imagePath: 'assets/Night.png',
                  ),
                  Divider(
                    color: Color(0xffAFAFAF),
                  ),
                  ServiceListTile(
                    title: "Intercity Rides",
                    value: intercityRide,
                    onChanged: (value) {
                      // setState(() {
                      //   intercityRide = value;
                      // });
                    },
                    imagePath: 'assets/SchoolRide.png',
                  ),
                  Divider(
                    color: Color(0xffAFAFAF),
                  ),
                  Text(
                    'To receive Ride request Please Turn on the button.',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: size.shortestSide * 0.038,
                      fontWeight: FontWeight.w700,
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
