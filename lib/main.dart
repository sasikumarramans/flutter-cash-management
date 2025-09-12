import 'package:ev_flutter_app/app.dart';
import 'package:ev_flutter_app/app/di/app_module.dart';
import 'package:ev_flutter_app/app/di/data_module.dart';
import 'package:ev_flutter_app/app/di/network_module.dart';
import 'package:ev_flutter_app/app/helpers/extensions/string_extensions.dart';
import 'package:ev_flutter_app/fcm_service.dart';
import 'package:ev_flutter_app/presentation/app_update/di/app_update_module.dart';
import 'package:ev_flutter_app/presentation/component/locale/di/locale_module.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

@pragma('vm:entry-point')
Future<void> backgroundMessageHandler(RemoteMessage message) async {
  try {
    print("FCMService: Background message received: ${message.data}");
    if (message.data.isNotEmpty) {
      FCMService.showBackgroundNotification(message);
    }
  } catch (e, stackTrace) {
    print("FCMService: Error handling background message: $e");
    print(stackTrace.toString());
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  await initModules();

  getFCMToken();
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  await initializeNotifications();
  lateInitModules();
}

void getFCMToken() async {
  String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
  debugPrint("FirebasePushNotification APNSToken: $apnsToken");

  String? token = await FirebaseMessaging.instance.getToken();
  debugPrint("FirebasePushNotification Token: $token");
}

Future<void> initializeNotifications() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings iosInitializationSettings =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: iosInitializationSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: handleNotificationTap,
    onDidReceiveBackgroundNotificationResponse:
        handleBackgroundNotificationResponse,
  );

  final notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    final response = notificationAppLaunchDetails!.notificationResponse;
    if (response != null) {
      handleNotificationTap(response);
    }
  }
}

void handleNotificationTap(NotificationResponse response) {
  if (!response.payload.isNullOrEmpty) {
    debugPrint("FCMService: handleNotificationTap");
  }
}

@pragma('vm:entry-point')
void handleBackgroundNotificationResponse(NotificationResponse response) {
  debugPrint("FCMService: handleBackgroundNotificationResponse");
  handleNotificationTap(response);
}

Future<void> initModules() async {
  final appModule = AppModule();
  await appModule.init(
    modules: [
      DataModule(),
      NetworkModule(),
      AppUpdateModule(),
      LocaleModule(),
    ],
  );

  runApp(const MyApp());
}

Future<void> lateInitModules() async {
  final appModule = AppModule();
  appModule.lateInit(
    modules: [
      DataModule(),
      NetworkModule(),
      AppUpdateModule(),
      LocaleModule(),
    ],
  );
}
