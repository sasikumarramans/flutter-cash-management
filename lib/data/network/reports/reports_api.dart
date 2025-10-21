import 'package:bearnshare/data/network/core/dio_client.dart';
import 'package:bearnshare/domain/reports/model/get_report_download_request.dart';
import 'package:bearnshare/domain/reports/model/get_report_download_response.dart';
import 'package:bearnshare/domain/reports/model/get_report_summary_request.dart';
import 'package:bearnshare/domain/reports/model/get_report_summary_response.dart';
import 'package:bearnshare/domain/reports/reports_repository.dart';
import 'package:get_it/get_it.dart';

class ReportsApi extends ReportsRepository {
  final _dioClient = GetIt.I<DioClient>();
  static const String _reportSummaryPath = '/api/reports/user/summary';
  static const String _reportDownloadPath = '/api/reports/pdf-url/user/summary';

  @override
  Future<ReportSummaryData> getReportSummary(
      GetReportSummaryRequest request) async {
    final response = await _dioClient.getRequest<ReportSummaryData>(
      _reportSummaryPath,
      queryParameters: request.toJson(),
      parseDataJson: ReportSummaryData.fromJson,
    );
    return response;
  }

  @override
  Future<GetReportDownloadResponse> getReportDownloadUrl(
      GetReportDownloadRequest request) async {
    final response = await _dioClient.getRequest<GetReportDownloadResponse>(
      _reportDownloadPath,
      queryParameters: request.toJson(),
      parseDataJson: GetReportDownloadResponse.fromJson,
    );
    return response;
  }
}
