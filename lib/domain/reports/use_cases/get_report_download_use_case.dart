import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:bearnshare/domain/reports/model/get_report_download_request.dart';
import 'package:bearnshare/domain/reports/model/get_report_download_response.dart';
import 'package:bearnshare/domain/reports/reports_repository.dart';
import 'package:get_it/get_it.dart';

class GetReportDownloadUseCase
    extends BaseUseCase<GetReportDownloadRequest, GetReportDownloadResponse> {
  final _reportsRepository = GetIt.I<ReportsRepository>();
  @override
  Future<GetReportDownloadResponse> execute({
    GetReportDownloadRequest? request,
  }) async {
    return await _reportsRepository.getReportDownloadUrl(request!);
  }
}
