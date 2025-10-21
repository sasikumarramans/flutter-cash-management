import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:bearnshare/domain/ledger/ledger_repository.dart';
import 'package:bearnshare/domain/ledger/model/create_book_request.dart';
import 'package:bearnshare/domain/ledger/model/create_book_response.dart';
import 'package:get_it/get_it.dart';

class CreateBookUseCase
    extends BaseUseCase<CreateBookRequest, CreateBookResponse> {
  final _ledgerRepository = GetIt.I.get<LedgerRepository>();

  @override
  Future<CreateBookResponse> execute({CreateBookRequest? request}) async {
    return await _ledgerRepository.createBook(request!);
  }
}
