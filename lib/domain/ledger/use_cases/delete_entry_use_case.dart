import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:bearnshare/domain/ledger/ledger_repository.dart';
import 'package:bearnshare/domain/ledger/model/create_entry_response.dart';
import 'package:get_it/get_it.dart';

class DeleteEntryUseCase extends BaseUseCase<int, CreateEntryResponse> {
  final _ledgerRepository = GetIt.I.get<LedgerRepository>();

  @override
  Future<CreateEntryResponse> execute({int? request}) async {
    return await _ledgerRepository.deleteEntry(request!);
  }
}
