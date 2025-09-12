import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ev_flutter_app/domain/notification/model/notification_entity.dart';
import 'package:ev_flutter_app/domain/notification/model/notification_modal.dart';
import 'package:ev_flutter_app/generated/l10n.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificationService {
  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _localNotifications;
  final StreamController<NotificationEntity> _notificationController;
  final StreamController<NotificationEntity> _notificationClickController;
  late AndroidNotificationChannel channel;
  final StreamController<String> _tokenController;

  FirebaseNotificationService(
      {required FirebaseMessaging messaging,
      required FlutterLocalNotificationsPlugin localNotifications})
      : _messaging = messaging,
        _localNotifications = localNotifications,
        _notificationController =
            StreamController<NotificationEntity>.broadcast(),
        _notificationClickController =
            StreamController<NotificationEntity>.broadcast(),
        _tokenController = StreamController<String>.broadcast();

  Stream<String> get tokenStream => _tokenController.stream;

  Stream<NotificationEntity> get notificationStream =>
      _notificationController.stream;

  Stream<NotificationEntity> get notificationClickStream =>
      _notificationClickController.stream;

  Future<void> initialize() async {
    await _setupNotificationChannel();
    await _initializeLocalNotifications();
    await _configureFirebaseMessaging();
    await _checkInitialNotification();
    await _setupTokenRefresh();
  }

  Future<void> _checkInitialNotification() async {
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      await handleMessageOpenedApp(initialMessage);
    }
  }

  Future<void> _setupNotificationChannel() async {
    channel = AndroidNotificationChannel(
      S().s_high_importance_channel,
      S().s_high_importance_notification,
      description: S().s_high_importance_channel_desc,
      importance: Importance.high,
      ledColor: Colors.green,
      enableLights: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> _initializeLocalNotifications() async {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    await _localNotifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse: _handleNotificationResponse);
  }

  Future<void> _configureFirebaseMessaging() async {
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> requestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
  }

  Future<void> handleForegroundMessage(RemoteMessage message) async {
    final notification = NotificationModel.fromRemoteMessage(message);
    _notificationController.add(notification);
    await _showLocalNotification(notification);
  }

  Future<void> _showLocalNotification(NotificationModel notification) async {
    if (!Platform.isAndroid) return;

    await _localNotifications.show(
      0,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          color: Colors.green,
          priority: Priority.high,
          colorized: true,
          icon: 'ic_notification',
        ),
      ),
      payload: jsonEncode(notification.content),
    );
  }

  Future<void> handleMessageOpenedApp(RemoteMessage message) async {
    final notification = NotificationModel.fromRemoteMessage(message);
    _notificationClickController.add(notification);
  }

  void _handleNotificationResponse(NotificationResponse response) {
    if (response.payload == null) return;
    final data = jsonDecode(response.payload!);
    final notification = NotificationModel.fromRemoteMessage(
      RemoteMessage(data: data),
    );
    _notificationClickController.add(notification);
  }

  void dispose() {
    _notificationController.close();
    _notificationClickController.close();
  }

  Future<String?> getFcmToken() async {
    return await _messaging.getToken();
  }

  Future<void> _setupTokenRefresh() async {
    final initialToken = await getFcmToken();
    if (initialToken != null) {
      _tokenController.add(initialToken);
    }
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      _tokenController.add(token);
    });
  }
}
