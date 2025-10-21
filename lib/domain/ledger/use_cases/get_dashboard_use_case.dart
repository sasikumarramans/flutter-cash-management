import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:bearnshare/domain/ledger/ledger_repository.dart';
import 'package:bearnshare/domain/ledger/model/get_dashboard_request.dart';
import 'package:bearnshare/domain/ledger/model/get_dashboard_response.dart';
import 'package:get_it/get_it.dart';

class GetDashboardUseCase
    extends BaseUseCase<GetDashboardRequest, DashboardResponse> {
  final _ledgerRepository = GetIt.I<LedgerRepository>();

  @override
  Future<DashboardResponse> execute({GetDashboardRequest? request}) async {
    return await _ledgerRepository.getDashboard(request!);
  }
}
