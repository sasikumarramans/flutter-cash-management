import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ev_flutter_app/domain/notification/notification_repository.dart';

class HandleNotificationUseCase {
  final NotificationRepository repository;

  HandleNotificationUseCase(this.repository);

  Future<void> handleBackground(RemoteMessage message) async {
    await repository.handleBackgroundMessage(message);
  }

  Future<void> handleForeground(RemoteMessage message) async {
    await repository.handleForegroundMessage(message);
  }
}
