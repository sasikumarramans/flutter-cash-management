import 'package:bearnshare/domain/notification/model/notification_entity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationRepository {
  Future<void> initialize();
  Future<void> requestPermission();
  Future<void> subscribeToTopic(String topic);
  Future<void> handleBackgroundMessage(RemoteMessage message);
  Future<void> handleForegroundMessage(RemoteMessage message);
  Future<void> handleMessageOpenedApp(RemoteMessage message);
  Future<String?> getFcmToken();
  Future<void> updateFcmToken(String token);
  Stream<NotificationEntity> get notificationStream;
  Stream<NotificationEntity> get notificationClickStream;
}
