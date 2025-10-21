class GetDashboardRequest {
  final double goalAmount;

  GetDashboardRequest({
    required this.goalAmount,
  });

  Map<String, dynamic> toJson() {
    return {
      'goalAmount': goalAmount,
    };
  }
}
