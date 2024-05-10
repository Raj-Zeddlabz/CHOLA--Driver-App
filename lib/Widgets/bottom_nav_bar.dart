import 'package:chola_driver_flutter/Constants/custom_icons.dart';
import 'package:chola_driver_flutter/Pages/Earning.dart';
import 'package:chola_driver_flutter/Pages/HomePage.dart';
import 'package:chola_driver_flutter/Pages/Service.dart';
import 'package:chola_driver_flutter/Pages/customer_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int selectedindex = 1;
  PageController pageController = PageController(initialPage: 1);

  void onItemTap(int index) {
    setState(() {
      selectedindex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          ServicePage(),
          HomePage(),
          EarningPage(),
          CustomerService(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        iconSize: 40,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        // unselectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
        selectedLabelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          fontSize: 18.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          // color: Colors.amber,
        ),
        unselectedFontSize: 18.sp,
        selectedFontSize: 18.sp,
        unselectedLabelStyle: TextStyle(
          fontSize: 18.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        showSelectedLabels: true,
        useLegacyColorScheme: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Services'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Map'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                CustomIcons.earning,
                width: 40.w,
                height: 40.w,
              ),
              label: 'Earning'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                CustomIcons.support,
                width: 40.w,
                height: 40.w,
              ),
              label: 'Support'),
        ],
        currentIndex: selectedindex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.shade700,
        onTap: onItemTap,
        showUnselectedLabels: true,
      ),
    );
  }
}
