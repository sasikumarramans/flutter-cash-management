import 'package:bearnshare/app/di/base/injectable_module.dart';
import 'package:bearnshare/data/network/ledger/ledger_api.dart';
import 'package:bearnshare/domain/ledger/ledger_repository.dart';
import 'package:bearnshare/domain/ledger/use_cases/create_book_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/delete_book_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/delete_entry_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/edit_book_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/get_book_by_id_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/get_books_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/get_dashboard_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/get_entries_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/search_books_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/search_entries_use_case.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_bloc.dart';

class LedgerBookModule extends InjectableModule {
  @override
  Future<void> inject() async {
    safeRegisterSingleton<LedgerRepository>(() => LedgerApi());
    safeRegisterSingleton<GetEntriesUseCase>(() => GetEntriesUseCase());
    safeRegisterSingleton<SearchEntriesUseCase>(() => SearchEntriesUseCase());
    safeRegisterSingleton<CreateBookUseCase>(() => CreateBookUseCase());
    safeRegisterSingleton<EditBookUseCase>(() => EditBookUseCase());
    safeRegisterSingleton<DeleteBookUseCase>(() => DeleteBookUseCase());
    safeRegisterSingleton<GetBooksUseCase>(() => GetBooksUseCase());
    safeRegisterSingleton<SearchBooksUseCase>(() => SearchBooksUseCase());
    safeRegisterSingleton<DeleteEntryUseCase>(() => DeleteEntryUseCase());
    safeRegisterSingleton<GetBookByIdUseCase>(() => GetBookByIdUseCase());
    safeRegisterSingleton<GetDashboardUseCase>(() => GetDashboardUseCase());
  }

  @override
  void injectBloc() {
    safeRegisterSingleton<LedgerBookBloc>(() => LedgerBookBloc());
  }

  @override
  void dispose() {
    safeUnregister<GetEntriesUseCase>();
    safeUnregister<SearchEntriesUseCase>();
    safeUnregister<CreateBookUseCase>();
    safeUnregister<EditBookUseCase>();
    safeUnregister<DeleteBookUseCase>();
    safeUnregister<GetBooksUseCase>();
    safeUnregister<SearchBooksUseCase>();
    safeUnregister<LedgerRepository>();
    safeUnregister<LedgerBookBloc>();
    safeUnregister<DeleteEntryUseCase>();
    safeUnregister<GetBookByIdUseCase>();
    safeUnregister<GetDashboardUseCase>();
  }
}
