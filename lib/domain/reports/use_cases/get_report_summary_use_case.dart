import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:bearnshare/domain/reports/model/get_report_summary_request.dart';
import 'package:bearnshare/domain/reports/model/get_report_summary_response.dart';
import 'package:bearnshare/domain/reports/reports_repository.dart';
import 'package:get_it/get_it.dart';

class GetReportSummaryUseCase
    extends BaseUseCase<GetReportSummaryRequest, ReportSummaryData> {
  final _reportsRepository = GetIt.I<ReportsRepository>();
  @override
  Future<ReportSummaryData> execute({
    GetReportSummaryRequest? request,
  }) async {
    return await _reportsRepository.getReportSummary(request!);
  }
}
