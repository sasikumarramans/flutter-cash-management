import 'package:bearnshare/app/di/base/injectable_module.dart';
import 'package:bearnshare/domain/ledger/use_cases/create_entry_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/delete_entry_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/update_entry_use_case.dart';
import 'package:bearnshare/presentation/ledger_entries/bloc/ledger_entries_bloc.dart';

class LedgerEntriesModule extends InjectableModule {
  @override
  Future<void> inject() async {
    safeRegisterSingleton<CreateEntryUseCase>(() => CreateEntryUseCase());
    safeRegisterSingleton<UpdateEntryUseCase>(() => UpdateEntryUseCase());
    safeRegisterSingleton<DeleteEntryUseCase>(() => DeleteEntryUseCase());
  }

  @override
  void injectBloc() {
    safeRegisterSingleton<LedgerEntriesBloc>(() => LedgerEntriesBloc());
  }

  @override
  void dispose() {
    safeUnregister<CreateEntryUseCase>();
    safeUnregister<UpdateEntryUseCase>();
    safeUnregister<DeleteEntryUseCase>();
    safeUnregister<LedgerEntriesBloc>();
  }
}
