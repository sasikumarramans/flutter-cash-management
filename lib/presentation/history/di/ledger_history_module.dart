import 'package:bearnshare/app/di/base/injectable_module.dart';
import 'package:bearnshare/domain/ledger/use_cases/get_recent_entries_use_case.dart';
import 'package:bearnshare/presentation/history/bloc/ledger_history_bloc.dart';

class LedgerHistoryModule extends InjectableModule {
  @override
  Future<void> inject() async {
    safeRegisterSingleton<GetRecentEntriesUseCase>(
        () => GetRecentEntriesUseCase());
  }

  @override
  void injectBloc() {
    safeRegisterSingleton<LedgerHistoryBloc>(() => LedgerHistoryBloc());
  }

  @override
  void dispose() {
    safeUnregister<GetRecentEntriesUseCase>();
    safeUnregister<LedgerHistoryBloc>();
  }
}
