class GetReportSummaryRequest {
  final String period;
  final int page;
  final int size;

  GetReportSummaryRequest({
    required this.period,
    this.page = 0,
    this.size = 10,
  });

  Map<String, dynamic> toJson() {
    return {
      'period': period,
      'page': page,
      'size': size,
    };
  }
}
