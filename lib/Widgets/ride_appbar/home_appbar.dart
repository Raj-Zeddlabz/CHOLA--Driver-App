import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Routes/routes.dart';
import 'package:chola_driver_flutter/Widgets/CustomMenuButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double preferredHeight;
  final VoidCallback? onPressed;
  final String title;

  const HomeAppBar(
      {Key? key,
      required this.preferredHeight,
      this.onPressed,
      required this.title})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(preferredHeight);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: preferredHeight,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: AppBar(
        elevation: 5,
        primary: false,
        title: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.black,
            ),
            minimumSize: MaterialStatePropertyAll(
              Size(
                size.width * 0.3,
                size.height * 0.06,
              ),
            ),
          ),
          onPressed: () {
            Constants.showError(context,
                "Stay Tuned for an Exciting Addition! We're thrilled to announce a new feature coming your way!");

            //Navigator to Earning
          },
          child: Text(
            'INR 00.00',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: Colors.white,
              fontSize: size.shortestSide * 0.06,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        leading: InkWell(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: CustomMenuIconButton(
            // onPressed: Get.toNamed(RoutesHelper.sidemenu),
            child_widget: Image.asset(
              'assets/Menu.png',
            ),
          ),
        ),
        // leadingWidth: MediaQuery.of(context).size.width * 0.15,
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.016,
              // vertical: size.height * 0.02,
            ),
            child: CircleAvatar(
              backgroundColor: Colors.black,
              child: IconButton(
                onPressed: () {
                  // Get.offAllNamed(RoutesHelper.bottomnavbar);

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => HomePage(),
                  //   ),
                  // );
                  Constants.showError(context,
                      "Stay Tuned for an Exciting Addition! We're thrilled to announce a new feature coming your way!");
                },
                icon: Icon(
                  Icons.notifications,
                  color: Colors.amber,
                ),
              ),
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.01,
                ),
                child: Text(
                  'OWN VEHICLE',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 24 / 375 * size.shortestSide,
                    fontFamily: 'RaviPrakash',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
