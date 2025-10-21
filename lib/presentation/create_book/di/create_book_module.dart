import 'package:bearnshare/app/di/base/injectable_module.dart';
import 'package:bearnshare/data/network/ledger/ledger_api.dart';
import 'package:bearnshare/domain/ledger/ledger_repository.dart';
import 'package:bearnshare/domain/ledger/use_cases/create_book_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/edit_book_use_case.dart';
import 'package:bearnshare/presentation/create_book/bloc/create_book_bloc.dart';

class CreateBookModule extends InjectableModule {
  @override
  Future<void> inject() async {
    safeRegisterSingleton<LedgerRepository>(() => LedgerApi());
    safeRegisterSingleton<CreateBookUseCase>(() => CreateBookUseCase());
    safeRegisterSingleton<EditBookUseCase>(() => EditBookUseCase());
  }

  @override
  void injectBloc() {
    safeRegisterSingleton<CreateBookBloc>(() => CreateBookBloc());
  }

  @override
  void dispose() {
    safeUnregister<CreateBookUseCase>();
    safeUnregister<EditBookUseCase>();
    safeUnregister<LedgerRepository>();
    safeUnregister<CreateBookBloc>();
  }
}
