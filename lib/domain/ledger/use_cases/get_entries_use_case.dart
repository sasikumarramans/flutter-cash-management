import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:bearnshare/domain/ledger/ledger_repository.dart';
import 'package:bearnshare/domain/ledger/model/get_entries_request.dart';
import 'package:bearnshare/domain/ledger/model/get_entries_response.dart';
import 'package:get_it/get_it.dart';

class GetEntriesUseCase extends BaseUseCase<GetEntriesRequest, EntriesData> {
  final _ledgerRepository = GetIt.I.get<LedgerRepository>();

  @override
  Future<EntriesData> execute({GetEntriesRequest? request}) async {
    return await _ledgerRepository.getEntries(request!);
  }
}
