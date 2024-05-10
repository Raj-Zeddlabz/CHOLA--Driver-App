import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/ComingSoon.dart';
import 'package:chola_driver_flutter/Pages/LoginPage1.dart';
import 'package:chola_driver_flutter/Pages/Refer&Earn.dart';
import 'package:chola_driver_flutter/Pages/Setting.dart';
import 'package:chola_driver_flutter/Pages/TermsAndPrivacy1.dart';
import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
import 'package:chola_driver_flutter/Widgets/CustomMenuList.dart';
import 'package:chola_driver_flutter/main.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  @override
/// Builds the widget for the drawer.
///
/// The widget is a [ClipRRect] with a [Drawer] child. The drawer has a [Container]
/// child that contains a [Column] with multiple [Widget]s. The [Column] contains
/// a [DrawerHeader] with a gradient background and a [LayoutBuilder] child. The
/// [LayoutBuilder] child builds a [Row] with two [Flexible] children. The first
/// child is a [Column] with two [FittedBox] children. The second child is a
/// [GestureDetector] with a [Container] child. The [Container] child contains an
/// [Image.asset] widget. The [Column] contains an [Expanded] child with a
/// [ListView] child. The [ListView] contains multiple [CustomListTile1] widgets.
/// The [CustomListTile1] widgets contain an [Icon], a [Text] title, and an
/// [onTap] callback. The [ListView] also contains multiple [Divider] widgets
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
      child: Drawer(
        elevation: 5,
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.18,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF4123D2), Color(0xFF2a3372)],
                    ),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double titleFontSize = constraints.maxWidth * 0.15;
                      double subtitleFontSize = constraints.maxWidth * 0.05;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    'CHOLA',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: titleFontSize,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w900,
                                      height: 1,
                                      letterSpacing: 5,
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    'Chariots',
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: subtitleFontSize,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                      letterSpacing: 3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   width: constraints.maxWidth * 0.2,
                          // ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                child: Image.asset('assets/close.png'),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    CustomListTile1(
                      icon: Icons.person_outline_sharp,
                      title: 'Account',
                      onTap: () {
                        Constants.showError(context,
                            "Stay Tuned for an Exciting Addition! We're thrilled to announce a new feature coming your way!");
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => AccountPage()));
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomListTile1(
                      icon: Icons.person,
                      title: 'Profile',
                      onTap: () {
                        Constants.showError(context,
                            "Stay Tuned for an Exciting Addition! We're thrilled to announce a new feature coming your way!");
                      },
                    ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.02,
                    // ),
                    // CustomListTile1(
                    //   icon: Icons.bookmark_outline,
                    //   title: 'Address',
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => ComingSoon()));
                    //   },
                    // ),
                    Divider(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    CustomListTile1(
                      icon: Icons.credit_card_outlined,
                      title: 'Payments',
                      onTap: () {
                        Constants.showError(context,
                            "Stay Tuned for an Exciting Addition! We're thrilled to announce a new feature coming your way!");
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomListTile1(
                      icon: Icons.card_giftcard_sharp,
                      title: 'Refer & Earn',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReferAndEarn(),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomListTile1(
                      icon: Icons.add_card_rounded,
                      title: 'Gift Cards',
                      onTap: () {
                        Constants.showError(context,
                            "Stay Tuned for an Exciting Addition! We're thrilled to announce a new feature coming your way!");
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomListTile1(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Setting()));
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomListTile1(
                      icon: Icons.hourglass_top_outlined,
                      title: 'Venture',
                      onTap: () {
                        Constants.showError(context,
                            "Stay Tuned for an Exciting Addition! We're thrilled to announce a new feature coming your way!");
                      },
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    CustomListTile1(
                      icon: Icons.description_outlined,
                      title: 'Terms & Privacy Policy',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TermsAndPrivacy(),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomListTile1(
                      icon: Icons.headset_mic_outlined,
                      title: 'Support',
                      onTap: () {
                        Constants.showError(context,
                            "Stay Tuned for an Exciting Addition! We're thrilled to announce a new feature coming your way!");
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomListTile1(
                      icon: Icons.help_outline_outlined,
                      title: 'Help',
                      onTap: () {
                        Constants.showError(context,
                            "Stay Tuned for an Exciting Addition! We're thrilled to announce a new feature coming your way!");
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomListTile1(
                      icon: Icons.play_circle_outline,
                      title: 'Demo',
                      onTap: () {
                        Constants.showError(context,
                            "Stay Tuned for an Exciting Addition! We're thrilled to announce a new feature coming your way!");
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.13,
                  right: MediaQuery.of(context).size.width * 0.13,
                  bottom: MediaQuery.of(context).size.width * 0.07,
                ),
                child: AgreeButton(
                  buttonText: "Logout",
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          title: Text(
                            'Do you really want to Logout?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.w800,
                              fontSize:
                                  MediaQuery.of(context).size.shortestSide *
                                      0.05,
                            ),
                          ),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: AgreeButton(
                                    buttonText: "No",
                                    onPressed: () {
                                      Navigator.pop(
                                        context,
                                      );
                                    },
                                    fontSize: MediaQuery.of(context)
                                            .size
                                            .shortestSide *
                                        0.06,
                                    padding: 0.3,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                                Flexible(
                                  child: AgreeButton(
                                    buttonText: "Yes",
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginPage1(),
                                        ),
                                      );
                                    },
                                    fillColor: [
                                      Colors.black,
                                      Colors.black,
                                    ],
                                    fontSize: MediaQuery.of(context)
                                            .size
                                            .shortestSide *
                                        0.06,
                                    padding: 0.4,
                                  ),
                                )
                              ],
                            ),
                          ],
                        );
                      },
                    );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => MyHomePage()),
                    // );
                  },
                  padding: 0.6,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
