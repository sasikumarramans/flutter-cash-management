import 'dart:io';

import 'package:bearnshare/data/local/hive_manager.dart';
import 'package:bearnshare/presentation/notification/notification_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';

import 'app/router/router_manager.dart';

enum NotificationsType {
  VIDEO_GENERATION_COMPLETE,
  CREDITS_RENEWED,
  VIDEO_GENERATION_FAILED
}

class NotificationData {
  final String? route;
  final Map<dynamic, dynamic> payload;

  NotificationData({this.route, required this.payload});

  factory NotificationData.fromMap(Map<dynamic, dynamic> map) {
    return NotificationData(
      route: map['notificationType'] as String?,
      payload: map,
    );
  }
}

class FCMService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final RouterManager _routerManager = GetIt.I<RouterManager>();

  FCMService() {
    _initializeFCM();
  }

  void _initializeFCM() async {
    try {
      final settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        _setupMessageListeners();
        await _checkTerminatedState();
        await _initTokenHandling();
      } else {
        print("FCMService: Notification permission denied");
      }
    } catch (e, stackTrace) {
      print("FCMService: Error during initialization: $e");
      print(stackTrace.toString());
    }
  }

  void _setupMessageListeners() {
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
  }

  Future<void> _initTokenHandling() async {
    try {
      final token = await _firebaseMessaging.getToken();
      if (token != null) {
        print("FCMService: Token generated -> $token");
        if (GetIt.I<HiveManager>().getFromHive(HiveManager.userIdKey) !=
            null) {}
        GetIt.I<HiveManager>().saveToHive(HiveManager.notificationToken, token);
      }

      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        print("FCMService: Token refreshed -> $newToken");
      });
    } catch (e, stackTrace) {
      print("FCMService: Error fetching token: $e");
      print(stackTrace.toString());
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    print("FCMService: handleForegroundMessage");
    print("FCMService: Initial message found! Data: ${message.data}");
    if (message.data.isNotEmpty) {
      NotificationData data;
      if (Platform.isIOS) {
        data = NotificationData.fromMap(message.data["data"]);
      } else {
        data = NotificationData.fromMap(message.data);
      }
    }
  }

  static Future<void> showNotification(RemoteMessage message) async {
    NotificationData data;
    if (Platform.isIOS) {
      data = NotificationData.fromMap(message.data["data"]);
    } else {
      data = NotificationData.fromMap(message.data);
    }
    print(data.route);
    print("FCMService: showNotification");
  }

  void _navigateBasedOnNotification(NotificationData data) {
    if (data.payload.isNotEmpty) {
      print("FCMService: navigateBasedOnNotification");
    }
  }

  static Future<void> showBackgroundNotification(RemoteMessage message) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    NotificationManager notificationManager = NotificationManager(
        flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin);
    NotificationData data;
    if (Platform.isIOS) {
      data = NotificationData.fromMap(message.data["data"]);
    } else {
      data = NotificationData.fromMap(message.data);
    }
    print(data.route);
    print("FCMService: showNotification");
  }

  static Future<String?> getThumbnailFilePath(String imageUrl) async {
    final cacheManager = DefaultCacheManager();
    final fileInfo = await cacheManager.getFileFromCache(imageUrl);
    if (fileInfo == null) {
      final downloadedFile = await cacheManager.getSingleFile(imageUrl);
      return downloadedFile.path;
    }
    return fileInfo.file.path;
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    if (message.data.isNotEmpty) {
      NotificationData data;
      if (Platform.isIOS) {
        data = NotificationData.fromMap(message.data["data"]);
      } else {
        data = NotificationData.fromMap(message.data);
      }
      _processMessage(data);
    }
  }

  Future<void> _checkTerminatedState() async {
    try {
      print("FCMService: Checking for terminated state notification...");

      final message = await _firebaseMessaging.getInitialMessage();
      if (message != null && message.data.isNotEmpty) {
        print("FCMService: Initial message found! Data: ${message.data}");
        NotificationData data;
        if (Platform.isIOS) {
          data = NotificationData.fromMap(message.data["data"]);
        } else {
          data = NotificationData.fromMap(message.data);
        }
        _processMessage(data);
      }
    } catch (e, stackTrace) {
      print("FCMService: Error checking terminated state: $e");
      print(stackTrace.toString());
    }
  }

  void _processMessage(NotificationData data) {
    _navigateBasedOnNotification(data);
  }
}
