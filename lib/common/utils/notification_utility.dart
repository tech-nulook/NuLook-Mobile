
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nulook_app/core/network/api_services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NotificationUtility {

  NotificationUtility._internal();
  static final NotificationUtility instance = NotificationUtility._internal();

  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static const String _badgeKey = 'notification_badge_count';

  // badge stream for UI listeners
  static final StreamController<int> _badgeController = StreamController<int>.broadcast();
  static Stream<int> get badgeStream => _badgeController.stream;

  // public wrappers
  static Future<void> setBadgeCount(int count) => _setBadgeCount(count);
  static Future<int> getBadgeCount() => _getBadgeCount();
  static Future<void> clearBadgeCount() => _clearBadgeCount();

  //Ask notification permission here
  static Future<NotificationSettings> _getNotificationPermission() async {
    return await FirebaseMessaging.instance.requestPermission(
      alert: false,
      announcement: false,
      badge: false,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );
  }

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    debugPrint("✅firebaseMessagingBackgroundHandler: ${message.notification?.title}");
    final int badge = message.data['badge'] != null ? int.tryParse(message.data['badge'].toString()) ?? 0 : 0;
    await _setBadgeCount(badge);
    displayNotification(
        message.notification?.title ?? "New Message",
        message.notification?.body ?? "",
        message.data['image'],
        message.data["payload"]);

    // handle background message
    // if message contains badge number, update badge
    debugPrint(' ✅ badge count set to $badge');
    // FlutterAppBadger.updateBadgeCount(badge);
  }

  Future<void> setUpNotificationService(BuildContext context) async {
    NotificationSettings notificationSettings = await FirebaseMessaging.instance.getNotificationSettings();
    //ask for permission
    if (notificationSettings.authorizationStatus == AuthorizationStatus.notDetermined) {
      notificationSettings = await _getNotificationPermission();

      //if permission is provisionnal or authorised
      if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized ||
          notificationSettings.authorizationStatus == AuthorizationStatus.provisional) {
        initialize(context);
      }

      //if permission denied
    } else if (notificationSettings.authorizationStatus == AuthorizationStatus.denied) {
      //If user denied then ask again
      notificationSettings = await _getNotificationPermission();
      if (notificationSettings.authorizationStatus == AuthorizationStatus.denied) {
        return;
      }
    }
    initialize(context);
  }

  // Foreground + Background listeners
  static void initialize(BuildContext context) {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    // Setup background handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    if (!kIsWeb) {
      _initLocalNotification(context);
    }
    _configureFCMListeners(context);

  }

  static void _initLocalNotification(BuildContext context) async {

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_nulook');

    DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      notificationCategories: [
        DarwinNotificationCategory(
          'demoCategory',
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.plain('id_1', 'Action 1'),
            DarwinNotificationAction.plain(
              'id_2',
              'Action 2',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.authenticationRequired,
              },
            ),
            DarwinNotificationAction.plain(
              'id_3',
              'Action 3',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.foreground,
              },
            ),
          ],
          options: <DarwinNotificationCategoryOption>{
            DarwinNotificationCategoryOption.allowAnnouncement,
          },
        )
      ]
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    _requestPermissionsForIos();
    await _localNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        //_onTapNotificationScreenNavigateCallback(notificationData: Map<String, dynamic>.from(jsonDecode(details.payload ?? "")), context: context);
        debugPrint("✅ Notification clicked Payload: ${ Map<String, dynamic>.from(jsonDecode(response.payload ?? "")) }");
      },
    );
  }

  // Foreground + Background listeners
  static void _configureFCMListeners(BuildContext context) {
    // Foreground notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint("title: ${ message.notification?.title}");
      debugPrint("body: ${ message.notification?.body}");
      debugPrint("imageUrl: ${ message.notification?.android!.imageUrl}");
      debugPrint("payload: ${ message.data['payload']}");
      debugPrint("✅ onMessage from Notification: ${message.notification?.title}");

      final int badge = message.data['badge'] != null ? int.tryParse(message.data['badge'].toString()) ?? 1 : 1;
      await _setBadgeCount(badge);
      debugPrint('✅ Badge count set to $badge');

      foregroundMessageListener(message, context);
    });

    // When app opened from notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("title: ${ message.notification?.title}");
      debugPrint("body: ${ message.notification?.body}");
      debugPrint("payload: ${ message.data['payload']}");
      debugPrint("🔔✅ onMessageOpenedApp from Notification: ${jsonEncode(message.data)}");
      onMessageOpenedAppListener(message, context);
    });

    FirebaseMessaging.instance.getInitialMessage().then((value) {
      //_onTapNotificationScreenNavigateCallback(notificationData: value?.data ?? {}, context: context);
    });
  }

  static void onMessageOpenedAppListener(RemoteMessage remoteMessage, BuildContext context) {
    NotificationUtility.setBadgeCount(0);
    //_onTapNotificationScreenNavigateCallback(notificationData: remoteMessage.data, context: context);
  }

  static void foregroundMessageListener(RemoteMessage message, BuildContext context) async {

    final additionalData = message.data;
    var title = message.notification?.title?? '';
    var body = message.notification?.body ?? '';
    var image = message.data['image'] ?? message.notification?.android!.imageUrl;
    if (message.data['type'] == 'message') {
      displayNotification(title, body, image, additionalData);
    } else {
      displayNotification(title, body, image, additionalData);
      //onReceiveNotification(message.data, context);
    }
    // final additionalData = message.data;
    // RemoteNotification notification = message.notification!;
    // var title = notification.title ?? '';
    // var body = notification.body ?? '';
    // var image = message.data['image'] ?? '';
    //
    // if (message.data['type'] == 'message') {
    //   // if (chatController.showNotification(message.data[ApiURL.userIdApiKey])) {
    //   //   displayNotification(title, body, image, additionalData);
    //   // }
    //   await NotificationUtility.instance.showNotification(
    //     title: message.notification?.title ?? "Notification",
    //     body: message.notification?.body ?? "",
    //     payload: message.data["payload"],
    //   );
    // } else {
    //   // displayNotification(title, body, image, additionalData);
    //   // onReceiveNotification(message.data, context);
    //   await NotificationUtility.instance.showNotification(
    //     title: message.notification?.title ?? "Notification",
    //     body: message.notification?.body ?? "",
    //     payload: message.data["payload"],
    //   );
    //
    // }
  }

  static displayNotification(String title, String body, String image, Map additionalData) async {
    // parse and persist badge from payload if present
    final int badge = additionalData['badge'] != null ? int.tryParse(additionalData['badge'].toString()) ?? 0 : 0;
    if (badge > 0) {
      await _setBadgeCount(badge);
    } else if (badge == 0) {
      // optionally clear badge if payload explicitly sends 0
      await _clearBadgeCount();
    }
    await createLocalNotification(dismissable: true, imageUrl: image, title: title, body: body, payload: jsonEncode(additionalData));
  }

  // Get token for push
  Future<String?> getDeviceToken() async {
    return Platform.isAndroid
        ? await FirebaseMessaging.instance.getToken()
        : await FirebaseMessaging.instance.getAPNSToken();
  }


  static Future<void> createLocalNotification({
    required String title,
    required bool dismissable,
    required String body,
    required String imageUrl,
    required String payload,
    int badge = 0,
  }) async {

    late AndroidNotificationDetails androidPlatformChannelSpecifics;
    late var downloadedImagePath = '';

    if (imageUrl.isNotEmpty) {
      downloadedImagePath = await _downloadAndSaveFile(imageUrl);
      if (downloadedImagePath.isEmpty) {
        ///If somwhow failed to download image
        androidPlatformChannelSpecifics = AndroidNotificationDetails(
            'com.affluora.nulookapp', //channel id
            'Local notification', //channel name
            icon: 'ic_nulook.png',
            importance: Importance.max,
            priority: Priority.high,
            ongoing: !dismissable,
            ticker: 'ticker',
            number: badge
        );
      } else {

        var bigPictureStyleInformation = BigPictureStyleInformation(
            FilePathAndroidBitmap(downloadedImagePath),
            largeIcon: FilePathAndroidBitmap(downloadedImagePath),
            hideExpandedLargeIcon: false,
            contentTitle: title,
            htmlFormatContentTitle: true,
            summaryText: title,
            htmlFormatSummaryText: true);

        androidPlatformChannelSpecifics = AndroidNotificationDetails(
            'com.affluora.nulookapp', //channel id
            'Local notification', //channel name
            icon: '@mipmap/ic_nulook',
            importance: Importance.max,
            priority: Priority.high,
            styleInformation: bigPictureStyleInformation,
            ongoing: !dismissable,
            color: Colors.white,
            actions: [
              AndroidNotificationAction(
                  'view_action',
                  'View',
                  titleColor: Colors.white,
                  showsUserInterface: true,
              ),
              AndroidNotificationAction(
                  'dismiss_action',
                  'Dismiss',
                  cancelNotification: true,
                  titleColor: Colors.white,
                  showsUserInterface: true
              ),
            ],
            ticker: 'ticker',
            number: badge
        );
      }
    } else {
      // final String largeIconPath = 'https://graphicsfamily.com/wp-content/uploads/2020/11/Professional-Web-Banner-AD-in-Photoshop-scaled.jpg';
      // final downloadedImagePath = await _downloadAndSaveFile(largeIconPath);
      // var bigPictureStyleInformation = BigPictureStyleInformation(
      //     FilePathAndroidBitmap(downloadedImagePath),
      //     largeIcon: FilePathAndroidBitmap(downloadedImagePath),
      //     hideExpandedLargeIcon: true,
      //     contentTitle: title,
      //     htmlFormatContentTitle: true,
      //     summaryText: title,
      //     htmlFormatSummaryText: true);
      androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'com.affluora.nulookapp', //channel id
          'Local notification', //channel name
          icon: '@mipmap/ic_nulook',
          playSound: true,
          importance: Importance.max,
          priority: Priority.high,
          ongoing: !dismissable,
          actions: [
            AndroidNotificationAction(
              'view_action',
              'View',
              titleColor: Colors.white,
              showsUserInterface: true
            ),
            AndroidNotificationAction(
              'dismiss_action',
              'Dismiss',
              cancelNotification: true,
              titleColor: Colors.white,
              showsUserInterface: true
            ),
          ],
          ticker: 'ticker',
          number: badge
      );
    }

    DarwinNotificationDetails iosNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      badgeNumber: 1,
      attachments: <DarwinNotificationAttachment>[
        ?downloadedImagePath.isNotEmpty ? DarwinNotificationAttachment(downloadedImagePath) : null
      ]
    );

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosNotificationDetails
    );

    await _localNotificationsPlugin.show(
        DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title, body,
        platformChannelSpecifics,
        payload: payload);
  }


  static Future<String> _downloadAndSaveFile(String url) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/temp.jpg';

    try {
      final response = await ApiServices().downloadFile(url, filePath, CancelToken());
      if (response.isSuccess && response.data != null) {
        final file = File(filePath);
        //await file.writeAsBytes(response.bodyBytes);
      }
      return filePath;
    } catch (e) {
      return "";
    }
  }

  static Future<void> _requestPermissionsForIos() async {
    if (Platform.isIOS) {
      _localNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions();
    }
  }

  // Badge helpers
  static Future<void> _setBadgeCount(int count) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_badgeKey, count);
      // notify listeners
      _badgeController.add(count);
      // if (count > 0) {
      //   if (await FlutterAppBadger.isAppBadgeSupported()) {
      //     FlutterAppBadger.updateBadgeCount(count);
      //   }
      // } else {
      //   if (await FlutterAppBadger.isAppBadgeSupported()) {
      //     FlutterAppBadger.removeBadge();
      //   }
      // }
    } catch (e) {
      debugPrint('Error setting badge count: $e');
    }
  }

  static Future<int> _getBadgeCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_badgeKey) ?? 0;
  }

  static Future<void> _clearBadgeCount() async {
    await _setBadgeCount(0);
  }

  // 6) Increment/decrement on per-notification actions
  Future<void> _markAsRead(String id) async {
    //await ApiService.markRead(id);
    final current = await NotificationUtility.getBadgeCount();
    final newCount = (current > 0) ? current - 1 : 0;
    await NotificationUtility.setBadgeCount(newCount);
  }

// 7) At app startup - restore server or persisted badge
// file: `lib/main.dart` (during init)
  Future<void> initializeBadge() async {
    final persisted = await NotificationUtility.getBadgeCount();
    if (persisted > 0) {
      await NotificationUtility.setBadgeCount(persisted);
    } else {
      //final serverCount = await ApiService.getBadgeCount();
      await NotificationUtility.setBadgeCount(0);
    }
  }


}