class GetReportDownloadRequest {
  final String period;

  GetReportDownloadRequest({
    required this.period,
  });

  Map<String, dynamic> toJson() {
    return {
      'period': period,
    };
  }
}
