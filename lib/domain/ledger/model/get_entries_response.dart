class EntriesResponse {
  final EntriesData data;
  final EntriesSummary summary;

  EntriesResponse({
    required this.data,
    required this.summary,
  });

  factory EntriesResponse.fromJson(Map<String, dynamic> json) {
    return EntriesResponse(
      data: EntriesData.fromJson(json),
      summary: EntriesSummary.fromJson(json['summary'] ?? {}),
    );
  }
}

class EntriesData {
  final List<EntryItem> content;
  final int totalPages;
  final int totalElements;
  final int currentPage;

  EntriesData({
    required this.content,
    required this.totalPages,
    required this.totalElements,
    required this.currentPage,
  });

  factory EntriesData.fromJson(Map<String, dynamic> json) {
    return EntriesData(
      content: (json['content'] as List?)
              ?.map((item) => EntryItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      totalPages: json['totalPages'] ?? 0,
      totalElements: json['totalElements'] ?? 0,
      currentPage: json['number'] ?? 0,
    );
  }
}

class EntriesSummary {
  final int totalEntries;
  final double totalCashIn;
  final double totalCashOut;

  EntriesSummary({
    required this.totalEntries,
    required this.totalCashIn,
    required this.totalCashOut,
  });

  factory EntriesSummary.fromJson(Map<String, dynamic> json) {
    return EntriesSummary(
      totalEntries: json['totalEntries'] ?? 0,
      totalCashIn: (json['totalCashIn'] ?? 0).toDouble(),
      totalCashOut: (json['totalCashOut'] ?? 0).toDouble(),
    );
  }
}

class EntryItem {
  final int id;
  final int bookId;
  final String title;
  final String? description;
  final double amount;
  final String type; // 'INCOME' or 'EXPENSE'
  final String? category;
  final String createdAt;
  final String? updatedAt;
  final String? dateTime;

  EntryItem({
    required this.id,
    required this.bookId,
    required this.title,
    this.description,
    required this.amount,
    required this.type,
    this.category,
    required this.createdAt,
    this.dateTime,
    this.updatedAt,
  });

  bool get isIncome => type.toLowerCase() == 'income';

  factory EntryItem.fromJson(Map<String, dynamic> json) {
    return EntryItem(
      id: json['id'] ?? 0,
      bookId: json['bookId'] ?? 0,
      title: json['name'] ?? '',
      description: json['description'],
      amount: (json['amount'] ?? 0).toDouble(),
      type: json['type'] ?? 'EXPENSE',
      category: json['category'],
      createdAt: json['createdAt'] ?? '',
      dateTime: json['dateTime'] ?? '',
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'bookId': bookId,
        'title': title,
        'description': description,
        'amount': amount,
        'type': type,
        'category': category,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'dateTime': dateTime,
      };
}
