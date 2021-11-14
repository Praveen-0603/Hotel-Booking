import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hotel_booking/Utils/download_image.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationController extends GetxController {
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
  );

  static final _notification = FlutterLocalNotificationsPlugin();
  // final _firebaseMessaging = FirebaseMessaging.instance;

  final _initializationsetiings = const InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: IOSInitializationSettings(),
  );

  @override
  void onInit() async {
    super.onInit();
    final token = await FirebaseMessaging.instance.getToken();
    print(token);
    // final NotificationAppLaunchDetails? details =
    //     await _notification.getNotificationAppLaunchDetails();
    // if (details != null && details.didNotificationLaunchApp) {
    //   Get.to(() => SimpleAnimation());
    // }
    _notification.initialize(
      _initializationsetiings,
      onSelectNotification: (payload) {
        if (payload != null) {
          Get.toNamed(payload);
        }
      },
    );
    await _notification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    tz.initializeTimeZones();
    setupInteractedMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        _notification.show(
          notification.hashCode,
          notification.title,
          notification.body,
          await _notificationdetails(imageurl: message.data['image']),
          payload: message.data['payload'],
        );
      }
    });
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['payload'] != null) {
      Get.toNamed(message.data['payload']);
    }
  }

  static Future _notificationdetails({String? imageurl}) async {
    String? bigimagepath;
    if (imageurl != null) {
      bigimagepath = await DownloadImage.downloadAndSaveFile(
        imageurl,
        'bigimage',
      );
    }
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.max,
    );

    return NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        playSound: true,
        color: Colors.blue,
        styleInformation: bigimagepath != null
            ? BigPictureStyleInformation(FilePathAndroidBitmap(bigimagepath))
            : null,
        importance: Importance.max,
        priority: Priority.max,
      ),
      iOS: const IOSNotificationDetails(),
    );
  }

  Future<void> shownotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    await _notification.show(
      id,
      title,
      body,
      await _notificationdetails(),
      payload: payload,
    );
  }

  Future<void> schedulenotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduletime,
    String? payload,
  }) async {
    await _notification.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
          scheduletime.isBefore(DateTime.now())
              ? scheduletime.add(1.days)
              : scheduletime,
          tz.local),
      await _notificationdetails(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  Future<void> closenotification() async {
    _notification.cancel(0);
  }

  Future<void> closeallnotifications() async {
    _notification.cancelAll();
  }
}
