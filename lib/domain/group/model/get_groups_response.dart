class GroupsResponse {
  final GroupsData data;
  GroupsResponse({
    required this.data,
  });
  factory GroupsResponse.fromJson(Map<String, dynamic> json) {
    return GroupsResponse(data: GroupsData.fromJsonList(json["content"]));
  }
}

class GroupsData {
  final List<GroupItem> content;

  GroupsData({
    required this.content,
  });

  static GroupsData fromJsonList(List<dynamic> jsonList) {
    return GroupsData(
      content: jsonList
          .map((json) => GroupItem.fromJson(json as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GroupItem {
  final int id;
  final String type;
  final String name;
  final String description;
  final String currency;
  final String adminUserId;
  final String adminUsername;
  final int memberCount;
  final List<GroupMember> members;
  final String createdAt;
  final double overallReceivingAmount;
  final double overallPayingAmount;
  final List<RecentGroupExpense> recentExpenses;

  GroupItem({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.currency,
    required this.adminUserId,
    required this.adminUsername,
    required this.memberCount,
    required this.members,
    required this.createdAt,
    required this.overallPayingAmount,
    required this.overallReceivingAmount,
    required this.recentExpenses,
  });

  factory GroupItem.fromJson(Map<String, dynamic> json) {
    return GroupItem(
      id: json['id'] ?? 0,
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      currency: json['currency'] ?? 'USD',
      adminUserId: json['adminUserId'] ?? '',
      adminUsername: json['adminUsername'] ?? '',
      memberCount: json['memberCount'] ?? 0,
      members: (json['members'] as List?)
              ?.map(
                  (item) => GroupMember.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: json['createdAt'] ?? '',
      overallPayingAmount: (json['overallPayingAmount'] ?? 0).toDouble(),
      overallReceivingAmount: (json['overallReceivingAmount'] ?? 0).toDouble(),
      recentExpenses: (json['recentExpenses'] as List?)
              ?.map((item) =>
                  RecentGroupExpense.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'name': name,
        'description': description,
        'currency': currency,
        'adminUserId': adminUserId,
        'adminUsername': adminUsername,
        'memberCount': memberCount,
        'members': members.map((m) => m.toJson()).toList(),
        'createdAt': createdAt,
      };
}

class GroupMember {
  final String userId;
  final String username;
  final String email;
  final String joinedAt;
  final bool admin;

  GroupMember({
    required this.userId,
    required this.username,
    required this.email,
    required this.joinedAt,
    required this.admin,
  });

  factory GroupMember.fromJson(Map<String, dynamic> json) {
    return GroupMember(
      userId: json['userId'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      joinedAt: json['joinedAt'] ?? '',
      admin: json['admin'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'username': username,
        'email': email,
        'joinedAt': joinedAt,
        'admin': admin,
      };
}

class RecentGroupExpense {
  final int id;
  final String description;
  final double totalAmount;
  final String currency;
  final String paidByUsername;
  final String paidByUserId;
  final double yourAmount;
  final String status;
  final String createdAt;

  RecentGroupExpense({
    required this.id,
    required this.description,
    required this.totalAmount,
    required this.currency,
    required this.paidByUsername,
    required this.paidByUserId,
    required this.yourAmount,
    required this.status,
    required this.createdAt,
  });

  factory RecentGroupExpense.fromJson(Map<String, dynamic> json) {
    return RecentGroupExpense(
      id: json['id'] ?? 0,
      description: json['description'] ?? '',
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      currency: json['currency'] ?? '',
      paidByUsername: json['paidByUsername'] ?? '',
      paidByUserId: json['paidByUserId'] ?? 'USD',
      yourAmount: (json['yourAmount'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}
