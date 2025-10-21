import 'package:bearnshare/domain/reports/model/get_report_download_request.dart';
import 'package:bearnshare/domain/reports/model/get_report_download_response.dart';
import 'package:bearnshare/domain/reports/model/get_report_summary_request.dart';
import 'package:bearnshare/domain/reports/model/get_report_summary_response.dart';

abstract class ReportsRepository {
  Future<ReportSummaryData> getReportSummary(GetReportSummaryRequest request);
  Future<GetReportDownloadResponse> getReportDownloadUrl(
      GetReportDownloadRequest request);
}
