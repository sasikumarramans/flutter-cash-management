class BooksResponse {
  final BooksData data;

  BooksResponse({
    required this.data,
  });

  factory BooksResponse.fromJson(Map<String, dynamic> json) {
    return BooksResponse(
      data: BooksData.fromJson(json),
    );
  }
}

class BooksData {
  final List<BooksItem> content;
  final int totalPages;
  final int totalElements;
  final int currentPage;

  BooksData({
    required this.content,
    required this.totalPages,
    required this.totalElements,
    required this.currentPage,
  });

  factory BooksData.fromJson(Map<String, dynamic> json) {
    return BooksData(
      content: (json['content'] as List?)
              ?.map((item) => BooksItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      totalPages: json['totalPages'] ?? 0,
      totalElements: json['totalElements'] ?? 0,
      currentPage: json['number'] ?? 0,
    );
  }
}

class BooksItem {
  final int id;
  final String name;
  final String description;
  final String currency;
  final String createdAt;
  final double totalExpense;
  final double totalIncome;
  final String? lastEntryDateTime;

  BooksItem({
    required this.id,
    required this.name,
    required this.description,
    required this.currency,
    required this.createdAt,
    required this.totalExpense,
    required this.totalIncome,
    this.lastEntryDateTime,
  });

  factory BooksItem.fromJson(Map<String, dynamic> json) {
    return BooksItem(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      currency: json['currency'] ?? 'INR',
      createdAt: json['createdAt'] ?? '',
      totalExpense: (json['totalExpense'] ?? 0).toDouble(),
      totalIncome: (json['totalIncome'] ?? 0).toDouble(),
      lastEntryDateTime: json['lastEntryDateTime'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'currency': currency,
        'createdAt': createdAt,
        'totalExpense': totalExpense,
        'totalIncome': totalIncome,
        'lastEntryDateTime': lastEntryDateTime,
      };
}
