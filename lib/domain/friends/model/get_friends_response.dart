class FriendsResponse {
  final FriendsData data;

  FriendsResponse({
    required this.data,
  });

  factory FriendsResponse.fromJson(Map<String, dynamic> json) {
    return FriendsResponse(
      data: FriendsData.fromJson(json),
    );
  }
}

class FriendsData {
  final int totalElements;
  final int totalPages;
  final bool first;
  final int size;
  final List<FriendItem> content;
  final int number;
  final bool last;
  final bool empty;

  FriendsData({
    required this.totalElements,
    required this.totalPages,
    required this.first,
    required this.size,
    required this.content,
    required this.number,
    required this.last,
    required this.empty,
  });

  factory FriendsData.fromJson(Map<String, dynamic> json) {
    return FriendsData(
      totalElements: json['totalElements'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      first: json['first'] ?? false,
      size: json['size'] ?? 0,
      content: (json['content'] as List?)
              ?.map((item) => FriendItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      number: json['number'] ?? 0,
      last: json['last'] ?? false,
      empty: json['empty'] ?? false,
    );
  }
}

class FriendItem {
  final String userId;
  final String username;
  final String name;
  final String email;
  final double overallPayingAmount;
  final double overallReceivingAmount;
  final List<RecentExpense> recentExpenses;

  FriendItem({
    required this.userId,
    required this.username,
    required this.name,
    required this.email,
    required this.overallPayingAmount,
    required this.overallReceivingAmount,
    required this.recentExpenses,
  });

  factory FriendItem.fromJson(Map<String, dynamic> json) {
    return FriendItem(
      userId: json['userId'] ?? '',
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      overallPayingAmount:
          (json['overallPayingAmount'] ?? 0).toDouble(),
      overallReceivingAmount:
          (json['overallReceivingAmount'] ?? 0).toDouble(),
      recentExpenses: (json['recentExpenses'] as List?)
              ?.map((item) =>
                  RecentExpense.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'username': username,
        'name': name,
        'email': email,
        'overallPayingAmount': overallPayingAmount,
        'overallReceivingAmount': overallReceivingAmount,
        'recentExpenses': recentExpenses.map((e) => e.toJson()).toList(),
      };
}

class RecentExpense {
  final int expenseId;
  final int groupId;
  final String groupName;
  final String description;
  final double totalAmount;
  final String currency;
  final double yourAmount;
  final String status;
  final String createdAt;

  RecentExpense({
    required this.expenseId,
    required this.groupId,
    required this.groupName,
    required this.description,
    required this.totalAmount,
    required this.currency,
    required this.yourAmount,
    required this.status,
    required this.createdAt,
  });

  factory RecentExpense.fromJson(Map<String, dynamic> json) {
    return RecentExpense(
      expenseId: json['expenseId'] ?? 0,
      groupId: json['groupId'] ?? 0,
      groupName: json['groupName'] ?? '',
      description: json['description'] ?? '',
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      currency: json['currency'] ?? 'USD',
      yourAmount: (json['yourAmount'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'expenseId': expenseId,
        'groupId': groupId,
        'groupName': groupName,
        'description': description,
        'totalAmount': totalAmount,
        'currency': currency,
        'yourAmount': yourAmount,
        'status': status,
        'createdAt': createdAt,
      };
}