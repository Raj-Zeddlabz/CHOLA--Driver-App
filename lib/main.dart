import 'dart:io' show Platform;
import 'package:chola_driver_flutter/Constants/Colors.dart';
import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/Earning.dart';
// import 'package:chola_driver_flutter/Pages/Login.dart';
import 'package:chola_driver_flutter/Pages/LoginPage1.dart';
import 'package:chola_driver_flutter/Routes/routes.dart';
// import 'package:chola_driver_flutter/Pages/Signup.dart';
import 'package:chola_driver_flutter/Services/Notification.dart';
import 'package:chola_driver_flutter/Services/ThemeProvider.dart';
import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
// import 'package:chola_driver_flutter/Widgets/LandingPageButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/smart_management.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'Pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:upgrader/upgrader.dart';
// import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
// Handles a Firebase Cloud Messaging (FCM) background message.
// The [message] parameter is the FCM message received in the background.
// Returns a [Future] that completes when the message is handled.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

// Main function to initialize Firebase, set system preferences, handle notifications, and run the main application.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseAppCheck.instance.activate();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.dark,
    ),
  );
  //Notification:
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key? key});

  @override

  /// Builds the widget tree for the application.
  ///
  /// The [context] parameter is the build context of the widget.
  ///
  /// Returns a [MaterialApp] widget that represents the root of the widget tree.
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(392.72, 872.72),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          ThemeMode themeMode = ThemeMode.system;
          return GetMaterialApp(
            smartManagement: SmartManagement.onlyBuilder,
            debugShowCheckedModeBanner: false,
            title: 'Chola Chariots',
            // theme: ThemeData(
            //   fontFamily: 'Poppins',
            //   colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFFFF8D7)),
            //   useMaterial3: true,
            // ),
            // theme: ThemeData(
            //   useMaterial3: true,
            //   fontFamily: 'Poppins',
            //   colorScheme: lightColorScheme,
            // ),
            // darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
            themeMode: themeMode,
            // darkTheme: ThemeData(
              // useMaterial3: true,
            //   fontFamily: 'Poppins',
            //   colorScheme: darkColorScheme,
            // ),
            theme: Provider.of<ThemeProvider>(context).themeDataStyle,
            darkTheme: ThemeDataStyle.dark,
            home: const SplashScreen(),
            getPages: RoutesHelper.routes,
            
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    PushNotificationService pushNotificationService =
        PushNotificationService(context, navigatorKey);
    pushNotificationService.initialize();
    Future<String?> token = pushNotificationService.getToken();
    print('Token on app start: $token');
    return _buildBody();
  }

  /// Builds the widget tree for the application.
  ///
  /// The [context] parameter is the build context of the widget.
  ///
  /// Returns the widget tree built by the `_buildBody()` function.
  Widget _buildBody() {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: _buildContent(),
      );
    } else {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: UpgradeAlert(
          dialogStyle: (Platform.isIOS)
              ? UpgradeDialogStyle.cupertino
              : UpgradeDialogStyle.material,
          showIgnore: false,
          showReleaseNotes: false,
          showLater: false,
          upgrader: Upgrader(
            messages: UpgraderMessages(
              code:
                  'A new version of the app is available. Please update to continue using the app.',
            ),
            languageCode: 'en',
          ),
          onUpdate: () {
            // Handle update
            Constants.navigateToUrl();
            return false; // Return false to close the dialog
          },
          child: _buildContent(),
        ),
      );
    }
  }

  // Builds the content widget for the application.
  Widget _buildContent() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        bottom: size.height * 0.1,
        top: size.height * 0.1,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/Chola_Logo.png',
                width: size.width,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                'Drive with CHOLA\n              Own a Chariot',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: size.shortestSide * 0.05867,
                  fontFamily: 'RacingSansOne',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 1.43,
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.2,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
              child: AgreeButton(
                buttonText: "Get Started",
                borderRadius: 12,
                onPressed: () {
                  Navigator.push(
                    context,
                    Platform.isIOS
                        ? CupertinoPageRoute(
                            builder: (context) => LoginPage1(),
                          )
                        : MaterialPageRoute(
                            builder: (context) => LoginPage1(),
                          ),
                  );
                },
                suffixWidget: Icon(
                  Icons.double_arrow,
                  color: Colors.white,
                ),
                padding: 0.7,
                fontSize: MediaQuery.of(context).size.shortestSide * 0.0533,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
