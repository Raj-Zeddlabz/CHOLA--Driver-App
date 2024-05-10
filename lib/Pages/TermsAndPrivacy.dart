import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Constants/TermAndPrivacy.dart';
// import 'package:chola_driver_flutter/Pages/AddDocument.dart';
import 'package:chola_driver_flutter/Pages/PartnerPreForm.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
import 'package:flutter/material.dart';

class TermsAndPrivacy extends StatefulWidget {
  const TermsAndPrivacy({Key? key}) : super(key: key);

  @override
  State<TermsAndPrivacy> createState() => _TermsAndPrivacyState();
}

class _TermsAndPrivacyState extends State<TermsAndPrivacy> {
  final String lastUpdatedDate = "January 4, 2024";
  final ScrollController _scrollController = ScrollController();
  bool atBottom = true;

  void initState() {
    super.initState();

    _scrollController.addListener(() {
      // Check if we are at the bottom of the scroll view
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        setState(() {
          atBottom = false;
        });
      } else {
        setState(() {
          atBottom = true;
        });
      }
    });
  }

  @override
    // Build method that constructs the UI for the screen displaying Terms & Privacy Policy.
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Scaffold(
          appBar: CustomAppBar(
            title: 'Terms & Privacy Policy',
            preferredHeight: MediaQuery.of(context).size.height * 0.08,
          ),
          //  AppBar(
          //   leading: BackButton1(),
          //   flexibleSpace: Container(
          //       decoration: BoxDecoration(
          //     color: Color(0xFFBAC1FF),
          //   )),
          //   title: Text(
          //     'Terms And Privacy Policy',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize: MediaQuery.of(context).size.shortestSide * 0.06,
          //       fontFamily: 'Poppins',
          //       fontWeight: FontWeight.w600,
          //       height: 0,
          //     ),
          //   ),
          //   centerTitle: true,
          // ),
          body: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Scrollbar(
                      thumbVisibility: true,
                      showTrackOnHover: true,
                      thickness: MediaQuery.of(context).size.width * 0.03,
                      radius: Radius.circular(6.0),
                      controller: _scrollController,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: TermsAndConditionsWidget(),
                        // Text(
                        //   termsAndConditions,
                        //   style: TextStyle(
                        //       fontSize: MediaQuery.of(context).size.width * 0.05),
                        // ),
                      ),
                    ),
                  ),

                  // // Display Last Updated Date
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 8.0),
                  //   child: Text(
                  //     'Last Updated: $lastUpdatedDate',
                  //     style: TextStyle(
                  //         fontSize: MediaQuery.of(context).size.width * 0.04,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.black),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          floatingActionButton: Visibility(
            visible: MediaQuery.of(context).orientation == Orientation.portrait,
            child: atBottom
                ? Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        // child: Container(
                        //   padding: EdgeInsets.symmetric(
                        //     horizontal:
                        //         MediaQuery.of(context).size.width * 0.25,
                        //   ),
                        //   child: ElevatedButton(
                        // onPressed: () {
                        //   _scrollController.animateTo(
                        //     _scrollController.position.maxScrollExtent,
                        //     duration: Duration(seconds: 2),
                        //     curve: Curves.easeInOut,
                        //   );
                        // },
                        //     style: ElevatedButton.styleFrom(
                        //       primary: Colors.white,
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(20),
                        //         side: BorderSide(
                        //           color: Colors.purple,
                        //         ),
                        //       ),
                        //     ),
                        //     child: Text(
                        //       'Scroll to Bottom',
                        //       style: TextStyle(
                        //         fontSize:
                        //             MediaQuery.of(context).size.width * 0.05,
                        //         fontWeight: FontWeight.bold,
                        //         foreground: Paint()
                        //           ..shader = LinearGradient(
                        //             colors: [
                        //               Color(0xFFB10C7B),
                        //               Color(0xEBB10C7B),
                        //               Color(0xFF3010C2)
                        //             ],
                        //           ).createShader(
                        //             Rect.fromLTWH(0.0, 0.0, 350.0, 400.0),
                        //           ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: Duration(seconds: 2),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Container(
                                width: size.width * 0.5,
                                height: size.height * 0.06,
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.01,
                                  vertical: size.height * 0.001,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Color(0xff6A4DE8),
                                    )),
                                child: Center(
                                  child: Text(
                                    'Scroll to Bottom',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: size.shortestSide * 0.055,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..shader = LinearGradient(
                                          colors: [
                                            Color(0xff1F2D60),
                                            Color(0xff6A4DE8),
                                          ],
                                        ).createShader(
                                          Rect.fromLTWH(0.0, 0.0, 350.0, 400.0),
                                        ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PartnerPreForm()),
                                );
                              },
                              child: Container(
                                width: size.width * 0.5,
                                height: size.height * 0.06,
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.01,
                                  vertical: size.height * 0.0001,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff1F2D60),
                                      Color(0xff6A4DE8),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.topRight,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Agree & Continue",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: size.shortestSide * 0.055,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            GestureDetector(
                              onTap: () {
                                _scrollController.animateTo(
                                  0,
                                  duration: Duration(seconds: 1),
                                  curve: Curves.easeInOut,
                                );
                                setState(() {
                                  atBottom = !atBottom;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: size.height * 0.06,
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.01,
                                  vertical: size.height * 0.001,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Color(0xff6A4DE8),
                                    )),
                                child: Center(
                                  child: Text(
                                    'Scroll to Top',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: size.shortestSide * 0.055,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..shader = LinearGradient(
                                          colors: [
                                            Color(0xff1F2D60),
                                            Color(0xff6A4DE8),
                                          ],
                                        ).createShader(
                                          Rect.fromLTWH(0.0, 0.0, 350.0, 400.0),
                                        ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // AgreeButton(
                            //     width: 0.5,
                            //     borderRadius: 30,
                            //     buttonText: "Agree & Continue",
                            //     fontsize: size.shortestSide * 0.055,
                            // onPressed: () {

                            // })
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: TermsAndPrivacy(),
//   ));
// }
