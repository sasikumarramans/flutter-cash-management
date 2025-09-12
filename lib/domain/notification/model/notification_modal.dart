import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ev_flutter_app/domain/notification/model/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel({
    required super.title,
    required super.body,
    required super.content,
    required super.type,
  });

  factory NotificationModel.fromRemoteMessage(RemoteMessage message) {
    final content = message.data['content'] is String
        ? jsonDecode(message.data['content'])
        : message.data['content'];

    return NotificationModel(
      title: content['title'] ?? 'No Title',
      body: content['payload'] ?? 'No Payload',
      content: message.data,
      type: _getNotificationType(content),
    );
  }

  static NotificationType _getNotificationType(Map<String, dynamic> content) {
    if (content['feedbackNotifications'] != null) {
      return NotificationType.feedback;
    }
    return NotificationType.general;
  }
}
