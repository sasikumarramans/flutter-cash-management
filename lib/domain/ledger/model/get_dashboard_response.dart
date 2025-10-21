class DashboardResponse {
  final bool success;
  final String message;
  final DashboardData data;
  final String? error;

  const DashboardResponse({
    required this.success,
    required this.message,
    required this.data,
    this.error,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: DashboardData.fromJson(json),
      error: json['error'],
    );
  }
}

class DashboardData {
  final double totalExpense;
  final double totalIncome;
  final double totalSavings;
  final double thisMonthExpense;
  final double thisMonthIncome;
  final double thisMonthSavings;
  final double goalAmount;
  final double goalProgress;
  final double goalReachedAmount;

  const DashboardData({
    required this.totalExpense,
    required this.totalIncome,
    required this.totalSavings,
    required this.thisMonthExpense,
    required this.thisMonthIncome,
    required this.thisMonthSavings,
    required this.goalAmount,
    required this.goalProgress,
    required this.goalReachedAmount,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      totalExpense: (json['totalExpense'] ?? 0).toDouble(),
      totalIncome: (json['totalIncome'] ?? 0).toDouble(),
      totalSavings: (json['totalSavings'] ?? 0).toDouble(),
      thisMonthExpense: (json['thisMonthExpense'] ?? 0).toDouble(),
      thisMonthIncome: (json['thisMonthIncome'] ?? 0).toDouble(),
      thisMonthSavings: (json['thisMonthSavings'] ?? 0).toDouble(),
      goalAmount: (json['goalAmount'] ?? 0).toDouble(),
      goalProgress: (json['goalProgress'] ?? 0).toDouble(),
      goalReachedAmount: (json['goalReachedAmount'] ?? 0).toDouble(),
    );
  }

  @override
  List<Object?> get props => [
        totalExpense,
        totalIncome,
        totalSavings,
        thisMonthExpense,
        thisMonthIncome,
        thisMonthSavings,
        goalAmount,
        goalProgress,
        goalReachedAmount,
      ];
}
