import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:bearnshare/domain/ledger/ledger_repository.dart';
import 'package:bearnshare/domain/ledger/model/get_books_request.dart';
import 'package:bearnshare/domain/ledger/model/get_books_response.dart';
import 'package:get_it/get_it.dart';

class GetBooksUseCase extends BaseUseCase<GetBooksRequest, BooksResponse> {
  final _ledgerRepository = GetIt.I.get<LedgerRepository>();

  @override
  Future<BooksResponse> execute({GetBooksRequest? request}) async {
    return await _ledgerRepository.getBooks(request!);
  }
}
