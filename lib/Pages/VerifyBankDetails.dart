import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/AddDocument.dart';
// import 'package:chola_driver_flutter/Pages/HomePage.dart';
import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
import 'package:flutter/material.dart';

class VerifyBankDetails extends StatefulWidget {
  final String bankName;
  final String bankSite;
  const VerifyBankDetails({
    Key? key,
    required this.bankName,
    required this.bankSite,
  }) : super(key: key);

  @override
  State<VerifyBankDetails> createState() => _VerifyBankDetailsState();
}

class _VerifyBankDetailsState extends State<VerifyBankDetails> {
  bool isVerified = false;
  bool isCorrect = true;

  @override
      /// Initializes the state of the widget.
    ///
    /// This method is called when the widget is inserted into the tree. It sets the
    /// initial value of the `isVerified` variable to `false` and schedules a delayed
    /// callback to set the value to `true` after 5 seconds.
    ///
    /// This method does not take any parameters.
    ///
    /// This method does not return any value.
  void initState() {
    super.initState();
    isVerified = false;
    // Simulating verification after 10 seconds
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isVerified = true;
      });
    });
  }

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
          title: "Bank Verification",
          preferredHeight: size.height * 0.08,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SizedBox(
          height: size.height - statusBarHeight,
          child: Center(
            child: Column(
              mainAxisAlignment: !isVerified
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (isVerified)
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.1,
                          vertical: size.height * 0.05,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xffBAC1FF),
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: size.width * 0.8,
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.1,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    widget.bankName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: size.shortestSide * 0.06,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    widget.bankSite,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: size.shortestSide * 0.03,
                                      color: Color(0xff717171),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                (!isVerified)
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                        color: Color(0xff6A4DE8),
                      )
                    : Container(),
                SizedBox(
                  height: size.height * 0.02,
                ),
                if (isVerified)
                  CircleAvatar(
                    radius: size.shortestSide * 0.18,
                    backgroundColor: Color(0xffbebebe),
                    child: CircleAvatar(
                      // maxRadius: size.shortestSide * 0.15,
                      radius: size.shortestSide * 0.15,
                      backgroundColor:
                          isCorrect ? Color(0xff0bb000) : Color(0xff9D0F29),
                      child: Image.asset(
                        isCorrect ? 'assets/tick.png' : 'assets/cross_.png',
                        height: size.height * 0.1,
                      ),
                      // child: Icon(
                      //   Icons.check_circle,
                      //   color: Colors.green,
                      //   // size: size.shortestSide * 0.3,
                      // ),
                    ),
                  ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  isVerified
                      ? (isCorrect)
                          ? 'Great News!'
                          : 'Something Went Wrong!'
                      : 'Verifying Your Bank Account',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w700,
                    fontSize: isVerified
                        ? size.shortestSide * 0.07
                        : size.shortestSide * 0.05,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  isVerified
                      ? isCorrect
                          ? 'Your Bank Account Verified\n Successfully'
                          : "Bank details didn't match"
                      : '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff717171),
                    fontWeight: FontWeight.w700,
                    fontSize: isVerified
                        ? size.shortestSide * 0.05
                        : size.shortestSide * 0.05,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: (isVerified)
            ? SizedBox(
                height: size.height * 0.1,
                child: Center(
                  child: Column(
                    children: [
                      AgreeButton(
                        buttonText: (isCorrect) ? "Continue" : "Fix Now",
                        onPressed: () {
                          isCorrect
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddDocument(
                                      isVerifyAadhar: true,
                                      isVerifyPan: true,
                                      isVerifyDriverLicense: true,
                                      isVerifyPermanentAddress: true,
                                      isVerifyBankAccount: true,
                                      isVerifyPhoto: true,
                                    ),
                                  ),
                                )
                              : Navigator.pop(context);
                        },
                        padding: 0.6,
                      ),
                    ],
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
