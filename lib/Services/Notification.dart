import 'package:chola_driver_flutter/Pages/Earning.dart';
import 'package:chola_driver_flutter/Pages/HomePage.dart';
import 'package:chola_driver_flutter/Widgets/NotificationContent.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class PushNotificationService {
  GlobalKey<NavigatorState>? navigatorKey;
  late BuildContext context;
  bool isDialogShowing = false;
  int c = 0;

  PushNotificationService(BuildContext context, this.navigatorKey) {
    this.context = context;
  }
  FirebaseMessaging _fcm = FirebaseMessaging.instance;
    // Function that shows a push notification message as a modal bottom sheet.
  // Takes in the title and body of the notification as parameters.
  void showPushMessage(String? title, String? body) {
    if (!isDialogShowing) {
      isDialogShowing = true;
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isDismissible: false,
        builder: (BuildContext context) {
          return NotificationContent(
            title: title!,
            body: body!,
            onAccept: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              isDialogShowing = false;
            },
            onDecline: () {
              Navigator.pop(context);
              isDialogShowing = false;
            },
          );
        },
      );
    }
  }
    // Initializes the push notification service. Listens for incoming messages and handles them accordingly.

  Future<void> initialize() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      showPushMessage(
          message.notification!.title!, message.notification!.body!);
    });

    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) => showPushMessage(
          message.notification!.title!, message.notification!.body!),
    );

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        showPushMessage(
          message.notification!.title!,
          message.notification!.body!,
        );
      }
    });
  }
  // Asynchronously retrieves the token from Firebase Cloud Messaging (FCM).
  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    print('Token: $token');

    return token;
  }

  @pragma('vm:entry-point')
    /// Handles a Firebase Cloud Messaging (FCM) background message.
  ///
  /// The [message] parameter is the FCM message received in the background.
  ///
  /// Returns a [Future] that completes when the message is handled.
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }
}
