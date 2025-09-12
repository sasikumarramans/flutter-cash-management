class NotificationEntity {
  final String title;
  final String body;
  final Map<String, dynamic> content;
  final NotificationType type;

  NotificationEntity({
    required this.title,
    required this.body,
    required this.content,
    required this.type,
  });
}

enum NotificationType { feedback, general }
