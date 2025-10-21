class GetReportSummaryResponse {
  final bool success;
  final String message;
  final ReportSummaryData? data;
  final String? error;

  const GetReportSummaryResponse({
    required this.success,
    required this.message,
    this.data,
    this.error,
  });

  factory GetReportSummaryResponse.fromJson(Map<String, dynamic> json) {
    return GetReportSummaryResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? ReportSummaryData.fromJson(json['data'])
          : null,
      error: json['error'],
    );
  }
}

class ReportSummaryData {
  final double totalExpense;
  final double totalIncome;
  final double balance;
  final String startDate;
  final String endDate;
  final String period;
  final List<CategoryItem> expenseCategories;
  final List<CategoryItem> incomeCategories;

  const ReportSummaryData({
    required this.totalExpense,
    required this.totalIncome,
    required this.balance,
    required this.startDate,
    required this.endDate,
    required this.period,
    required this.expenseCategories,
    required this.incomeCategories,
  });

  factory ReportSummaryData.fromJson(Map<String, dynamic> json) {
    return ReportSummaryData(
      totalExpense: (json['totalExpense'] ?? 0).toDouble(),
      totalIncome: (json['totalIncome'] ?? 0).toDouble(),
      balance: (json['balance'] ?? 0).toDouble(),
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      period: json['period'] ?? '',
      expenseCategories: (json['expenseCategories'] as List<dynamic>?)
              ?.map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      incomeCategories: (json['incomeCategories'] as List<dynamic>?)
              ?.map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class CategoryItem {
  final String categoryName;
  final double totalAmount;
  final double percentage;
  final int transactionCount;

  const CategoryItem({
    required this.categoryName,
    required this.totalAmount,
    required this.percentage,
    required this.transactionCount,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      categoryName: json['categoryName'] ?? '',
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      percentage: (json['percentage'] ?? 0).toDouble(),
      transactionCount: json['transactionCount'] ?? 0,
    );
  }
}