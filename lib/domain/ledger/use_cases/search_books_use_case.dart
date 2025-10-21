import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:bearnshare/domain/ledger/ledger_repository.dart';
import 'package:bearnshare/domain/ledger/model/get_books_response.dart';
import 'package:bearnshare/domain/ledger/model/search_books_request.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class SearchBooksUseCase
    extends BaseUseCase<SearchBooksRequest, BooksResponse> {
  final _ledgerRepository = GetIt.I.get<LedgerRepository>();

  @override
  Future<BooksResponse> execute(
      {SearchBooksRequest? request, CancelToken? cancelToken}) async {
    return await _ledgerRepository.searchBooks(request!, cancelToken);
  }
}
