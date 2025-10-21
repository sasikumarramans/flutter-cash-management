import 'package:bearnshare/app/di/base/injectable_module.dart';
import 'package:bearnshare/app/helpers/download_manager.dart';
import 'package:bearnshare/app/helpers/share_manager.dart';
import 'package:bearnshare/data/network/reports/reports_api.dart';
import 'package:bearnshare/domain/reports/reports_repository.dart';
import 'package:bearnshare/domain/reports/use_cases/get_report_download_use_case.dart';
import 'package:bearnshare/domain/reports/use_cases/get_report_summary_use_case.dart';
import 'package:bearnshare/presentation/reports/bloc/reports_bloc.dart';

class ReportsModule extends InjectableModule {
  @override
  Future<void> inject() async {
    safeRegisterSingleton<ReportsRepository>(() => ReportsApi());
    safeRegisterSingleton<GetReportSummaryUseCase>(
        () => GetReportSummaryUseCase());
    safeRegisterSingleton<GetReportDownloadUseCase>(
        () => GetReportDownloadUseCase());
    safeRegisterSingleton<DownloadManager>(() => DownloadManager());
    safeRegisterSingleton<ShareManager>(() => ShareManager());
  }

  @override
  void injectBloc() {
    safeRegisterSingleton<ReportsBloc>(() => ReportsBloc());
  }

  @override
  void dispose() {
    safeUnregister<GetReportSummaryUseCase>();
    safeUnregister<DownloadManager>();
    safeUnregister<ShareManager>();
    safeUnregister<GetReportDownloadUseCase>();
    safeUnregister<ReportsRepository>();
    safeUnregister<ReportsBloc>();
  }
}
