import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/HomePage.dart';
import 'package:flutter/material.dart';
import '../main.dart';
// import 'package:chola_chariots_ui/Widgets/LanscapeIcon.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
    /// Initializes the state of the widget.
  ///
  /// This function is called when the widget is inserted into the tree. It
  /// invokes the `initState` function of the superclass and then schedules a
  /// delayed task to execute after 7 seconds. The delayed task fetches the
  /// result from `Constants.fetchResult()` and performs navigation based on
  /// the value of `x['alreadyExist']`. If `x['alreadyExist']` is `true`, it
  /// navigates to the `HomePage` using `Navigator.pushReplacement`. If it is
  /// `false` or `null`, it navigates to the `MyHomePage` using
  /// `Navigator.pushReplacement`.
  ///
  /// This function does not take any parameters and does not return anything.
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 7), () async {
      Map<String, dynamic> x = await Constants.fetchResult();
      print(x['alreadyExist']);
      (x['alreadyExist'] ?? false)
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            )
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(),
              ),
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash_1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Chola_Logo.png',
              width: size.width,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            // Image.asset(
            //   'assets/tagLine.png',
            //   width: size.width * 0.6,
            // ),
            Text(
              'Drive with CHOLA\n              Own a Chariot',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: size.shortestSide * 0.05867,
                fontFamily: 'RacingSansOne',
                fontWeight: FontWeight.w400,
                height: 0,
                letterSpacing: 1.43,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
