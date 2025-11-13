class GetSplitsResponse {
  final List<ExpenseItem> content;
  final int totalElements;
  final int totalPages;

  GetSplitsResponse({
    required this.content,
    required this.totalElements,
    required this.totalPages,
  });

  factory GetSplitsResponse.fromJson(Map<String, dynamic> json) {
    return GetSplitsResponse(
      content: (json['content'] as List?)
              ?.map((item) => ExpenseItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      totalElements: json['totalElements'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
    );
  }
}

class ExpenseItem {
  final int expenseId;
  final String description;
  final double totalAmount;
  final String currency;
  final String paidByUsername;
  final String paidByUserId;
  final double currentUserAmount;
  final int groupId;
  final String groupName;
  final String createdAt;

  ExpenseItem({
    required this.expenseId,
    required this.description,
    required this.totalAmount,
    required this.currency,
    required this.paidByUsername,
    required this.paidByUserId,
    required this.currentUserAmount,
    required this.groupId,
    required this.groupName,
    required this.createdAt,
  });

  factory ExpenseItem.fromJson(Map<String, dynamic> json) {
    return ExpenseItem(
      expenseId: json['expenseId'] ?? 0,
      description: json['description'] ?? '',
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      currency: json['currency'] ?? 'USD',
      paidByUsername: json['paidByUsername'] ?? '',
      paidByUserId: json['paidByUserId'] ?? '',
      currentUserAmount: (json['currentUserAmount'] ?? 0).toDouble(),
      groupId: json['groupId'] ?? 0,
      groupName: json['groupName'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'expenseId': expenseId,
        'description': description,
        'totalAmount': totalAmount,
        'currency': currency,
        'paidByUsername': paidByUsername,
        'paidByUserId': paidByUserId,
        'currentUserAmount': currentUserAmount,
        'groupId': groupId,
        'groupName': groupName,
        'createdAt': createdAt,
      };

  // Helper methods
  bool get isOwed => currentUserAmount > 0;
  bool get isReceiving => currentUserAmount < 0;
  String get amountLabel => isOwed ? 'To Pay' : 'You Receive';
}