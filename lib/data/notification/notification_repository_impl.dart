import 'dart:async';

import 'package:bearnshare/data/local/hive_manager.dart';
import 'package:bearnshare/data/notification/firebase_notification_service.dart';
import 'package:bearnshare/domain/notification/model/notification_entity.dart';
import 'package:bearnshare/domain/notification/notification_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final FirebaseNotificationService _notificationService;
  late final bool _hasRequiredDependencies;

  late final _hiveManager = GetIt.I<HiveManager>();
  NotificationRepositoryImpl(this._notificationService) {
    _hasRequiredDependencies = true;
    _setupTokenListener();
  }
  void _setupTokenListener() {
    _notificationService.tokenStream.listen(updateFcmToken);
  }

  @override
  Future<void> initialize() => _notificationService.initialize();

  @override
  Future<void> requestPermission() => _notificationService.requestPermission();

  @override
  Future<void> subscribeToTopic(String topic) =>
      _notificationService.subscribeToTopic(topic);

  @override
  Future<void> handleBackgroundMessage(RemoteMessage message) =>
      _notificationService.handleForegroundMessage(message);

  @override
  Future<void> handleForegroundMessage(RemoteMessage message) =>
      _notificationService.handleForegroundMessage(message);

  @override
  Future<void> handleMessageOpenedApp(RemoteMessage message) =>
      _notificationService.handleMessageOpenedApp(message);

  @override
  Stream<NotificationEntity> get notificationStream =>
      _notificationService.notificationStream;

  @override
  Stream<NotificationEntity> get notificationClickStream =>
      _notificationService.notificationClickStream;

  @override
  Future<String?> getFcmToken() => _notificationService.getFcmToken();

  @override
  Future<void> updateFcmToken(String token) async {
    if (!_hasRequiredDependencies) return;
  }
}
