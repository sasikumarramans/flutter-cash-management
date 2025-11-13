class ActivitiesResponse {
  final ActivitiesData data;

  ActivitiesResponse({
    required this.data,
  });

  factory ActivitiesResponse.fromJson(Map<String, dynamic> json) {
    return ActivitiesResponse(
      data: ActivitiesData.fromJson(json),
    );
  }
}

class ActivitiesData {
  final int totalElements;
  final int totalPages;
  final bool first;
  final int size;
  final List<ActivityItem> content;
  final int number;
  final bool last;
  final bool empty;

  ActivitiesData({
    required this.totalElements,
    required this.totalPages,
    required this.first,
    required this.size,
    required this.content,
    required this.number,
    required this.last,
    required this.empty,
  });

  factory ActivitiesData.fromJson(Map<String, dynamic> json) {
    return ActivitiesData(
      totalElements: json['totalElements'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      first: json['first'] ?? false,
      size: json['size'] ?? 0,
      content: (json['content'] as List?)
              ?.map(
                  (item) => ActivityItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      number: json['number'] ?? 0,
      last: json['last'] ?? false,
      empty: json['empty'] ?? false,
    );
  }
}

class ActivityItem {
  final int id;
  final String activityType;
  final String message;
  final Actor actor;
  final Target? target;
  final Context context;
  final String timestamp;

  ActivityItem({
    required this.id,
    required this.activityType,
    required this.message,
    required this.actor,
    this.target,
    required this.context,
    required this.timestamp,
  });

  factory ActivityItem.fromJson(Map<String, dynamic> json) {
    return ActivityItem(
      id: json['id'] ?? 0,
      activityType: json['activityType'] ?? '',
      message: json['message'] ?? '',
      actor: Actor.fromJson(json['actor'] ?? {}),
      target: json['target'] != null ? Target.fromJson(json['target']) : null,
      context: Context.fromJson(json['context'] ?? {}),
      timestamp: json['timestamp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'activityType': activityType,
        'message': message,
        'actor': actor.toJson(),
        'target': target?.toJson(),
        'context': context.toJson(),
        'timestamp': timestamp,
      };
}

class Actor {
  final String userId;
  final String username;
  final String name;

  Actor({
    required this.userId,
    required this.username,
    required this.name,
  });

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      userId: json['userId'] ?? '',
      username: json['username'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'username': username,
        'name': name,
      };
}

class Target {
  final String userId;
  final String username;
  final String name;

  Target({
    required this.userId,
    required this.username,
    required this.name,
  });

  factory Target.fromJson(Map<String, dynamic> json) {
    return Target(
      userId: json['userId'] ?? '',
      username: json['username'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'username': username,
        'name': name,
      };
}

class Context {
  final int? groupId;
  final String? groupName;
  final int? expenseId;
  final String? expenseDescription;
  final double? amount;
  final String? currency;

  final double overallReceivingAmount;
  final double overallPayingAmount;
  Context({
    this.groupId,
    this.groupName,
    this.expenseId,
    this.expenseDescription,
    this.amount,
    this.currency,
    required this.overallPayingAmount,
    required this.overallReceivingAmount,
  });

  factory Context.fromJson(Map<String, dynamic> json) {
    return Context(
      groupId: json['groupId'],
      groupName: json['groupName'],
      expenseId: json['expenseId'],
      expenseDescription: json['expenseDescription'],
      amount:
          json['amount'] != null ? (json['amount'] as num).toDouble() : null,
      currency: json['currency'],
      overallPayingAmount: (json['overallPayingAmount'] ?? 0).toDouble(),
      overallReceivingAmount: (json['overallReceivingAmount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'groupId': groupId,
        'groupName': groupName,
        'expenseId': expenseId,
        'expenseDescription': expenseDescription,
        'amount': amount,
        'currency': currency,
      };
}
