import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static void registerNotification() async {
    // 1. Instantiate Firebase Messaging

    final FlutterLocalNotificationsPlugin notificationsPlugin =
        FlutterLocalNotificationsPlugin();

    final FirebaseMessaging messaging = FirebaseMessaging.instance;

    final intializationSettings = InitializationSettings(
        android: const AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
            onDidReceiveLocalNotification: (id, title, body, payload) {


            }));

    notificationsPlugin.initialize(intializationSettings);

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      _getToken(FirebaseMessaging.instance);

      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {

        BigTextStyleInformation bigTextStyleInformation =
            BigTextStyleInformation(
          message.notification!.body!,
          htmlFormatBigText: true,
          contentTitle: message.notification!.title,
          htmlFormatContentTitle: true,
        );
        notificationsPlugin.show(
            0,
            message.notification!.title,
            message.notification!.body,
            NotificationDetails(
                android: AndroidNotificationDetails('idental', 'idental',
                    styleInformation: bigTextStyleInformation,
                    importance: Importance.high,
                    priority: Priority.high,
                    ticker: 'ticker',
                playSound: true)));

        // Parse the message received
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        // go to appointment screen whether to approve or not
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }
  static String? deviceToken;
  // final FirebaseMessaging messaging = FirebaseMessaging.instance;
  static void _getToken(FirebaseMessaging  messaging) async {
    deviceToken = await messaging.getToken();
    print(deviceToken); // print the device token string
  }

  static sendNotification(String token) async {
print("calleddd");
    await FirebaseMessaging.instance.sendMessage(
      data: <String,String>{
        'title': "test",
        "body": "new Appointment"
      },
      to: token


    );
  }

}
