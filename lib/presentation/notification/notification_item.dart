import 'package:flutter/material.dart';

enum NotificationType { progress, banner, action, simple }

class NotificationAction {
  final String label;
  final VoidCallback onPressed;
  NotificationAction({required this.label, required this.onPressed});
}

class NotificationItem {
  final String id;
  final NotificationType type;
  final String title;
  final String message;
  final double? progress;
  final List<NotificationAction>? actions;
  final String? payload;
  final String? thumbnailPath;

  NotificationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    this.progress,
    this.actions,
    this.payload,
    this.thumbnailPath,
  });

  NotificationItem copyWith({
    String? id,
    NotificationType? type,
    String? title,
    String? message,
    double? progress,
    List<NotificationAction>? actions,
    String? payload,
    String? thumbnailPath,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      message: message ?? this.message,
      progress: progress ?? this.progress,
      actions: actions ?? this.actions,
      payload: payload ?? this.payload,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
    );
  }
}
