import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_item.dart';

class NotificationManager {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationManager({required this.flutterLocalNotificationsPlugin});

  Future<void> showNotification(NotificationItem notification) async {
    final AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id',
      'General Notifications',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      largeIcon: notification.thumbnailPath != null
          ? FilePathAndroidBitmap(notification.thumbnailPath!)
          : null,
      styleInformation: const DefaultStyleInformation(true, true),
    );

    final DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      attachments: notification.thumbnailPath != null
          ? [DarwinNotificationAttachment(notification.thumbnailPath!)]
          : null,
      categoryIdentifier: 'videoReadyCategory',
    );

    NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      notification.id.hashCode,
      notification.title,
      notification.message,
      platformDetails,
      payload: notification.payload,
    );
  }

  void removeNotification(String id) {
    flutterLocalNotificationsPlugin.cancel(id.hashCode);
  }
}
