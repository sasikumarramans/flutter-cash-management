class GetReportDownloadResponse {
  final String downloadUrl;
  final String fileName;
  const GetReportDownloadResponse({
    required this.downloadUrl,
    required this.fileName,
  });

  factory GetReportDownloadResponse.fromJson(Map<String, dynamic> json) {
    print(json['downloadUrl']);
    print("downloadUrl");
    return GetReportDownloadResponse(
      downloadUrl: json['downloadUrl'] ?? "",
      fileName: json['fileName'] ?? "",
    );
  }
}
