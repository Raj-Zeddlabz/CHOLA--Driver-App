import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/AddDocumnetsScreen.dart';
import 'package:chola_driver_flutter/Pages/HomePage.dart';
import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
import 'package:chola_driver_flutter/Widgets/DocumentButton.dart';
import 'package:flutter/material.dart';

class AdditionalDocumnets extends StatefulWidget {
  const AdditionalDocumnets({super.key});

  @override
  State<AdditionalDocumnets> createState() => _AdditionalDocumnetsState();
}

class _AdditionalDocumnetsState extends State<AdditionalDocumnets> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(
        top: statusBarHeight,
      ),
      child: SizedBox(
        height: size.height - statusBarHeight,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: CustomAppBar(
            title: "Additional Documents",
            preferredHeight: size.height * 0.08,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.05,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.02,
                      vertical: size.height * 0.01,
                    ),
                    child: Container(
                      width: size.width,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white),
                          padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                              vertical: size.height * 0.03,
                            ),
                          ),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          alignment: Alignment.center,
                          elevation: MaterialStatePropertyAll(5.0),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddDocumnetsScreen(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                "Add Documents",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: size.shortestSide * 0.05,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                                size: size.shortestSide * 0.09,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.035,
                  ),
                  SizedBox(
                    width: size.shortestSide * 0.917,
                    child: Text(
                      'Add Additional documents to maximize chance of getting CHOLA approvals faster. \nYou can add as many documents you want.\nAddition documents may contain but not limited to Birth Certificate, Marriage Certificate, Ration Card, Etc.',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 0.04 * size.shortestSide,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.035,
                  ),
                  AgreeButton(
                    buttonText: "Skip",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    // padding: 0.65,
                    padding: 0.65,
                    borderRadius: 12,
                    suffixWidget: Icon(
                      Icons.double_arrow,
                      color: Colors.white,
                    ),
                    fontSize: size.shortestSide * 0.05333,
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
