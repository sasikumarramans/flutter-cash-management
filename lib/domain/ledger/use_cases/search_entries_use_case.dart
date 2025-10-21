import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:bearnshare/domain/ledger/ledger_repository.dart';
import 'package:bearnshare/domain/ledger/model/get_entries_response.dart';
import 'package:bearnshare/domain/ledger/model/search_entries_request.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class SearchEntriesUseCase
    extends BaseUseCase<SearchEntriesRequest, EntriesData> {
  final _ledgerRepository = GetIt.I.get<LedgerRepository>();

  @override
  Future<EntriesData> execute(
      {SearchEntriesRequest? request, CancelToken? cancelToken}) async {
    return await _ledgerRepository.searchEntries(request!, cancelToken);
  }
}
