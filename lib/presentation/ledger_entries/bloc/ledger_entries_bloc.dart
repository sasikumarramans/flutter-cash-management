import 'dart:async';

import 'package:bearnshare/app/bloc/base/base_bloc.dart';
import 'package:bearnshare/app/router/router_manager.dart';
import 'package:bearnshare/domain/ledger/model/create_entry_request.dart';
import 'package:bearnshare/domain/ledger/model/create_entry_response.dart';
import 'package:bearnshare/domain/ledger/model/update_entry_request.dart';
import 'package:bearnshare/domain/ledger/use_cases/create_entry_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/delete_entry_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/get_entries_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/update_entry_use_case.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_bloc.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_event.dart';
import 'package:bearnshare/presentation/ledger_entries/bloc/ledger_entries_event.dart';
import 'package:bearnshare/presentation/ledger_entries/bloc/ledger_entries_state.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class LedgerEntriesBloc
    extends BaseBloc<LedgerEntriesEvent, LedgerEntriesState> {
  late final _createEntryUseCase = GetIt.I.get<CreateEntryUseCase>();
  late final _updateEntryUseCase = GetIt.I.get<UpdateEntryUseCase>();
  late final _deleteEntryUseCase = GetIt.I.get<DeleteEntryUseCase>();
  late final _getEntriesUseCase = GetIt.I.get<GetEntriesUseCase>();

  LedgerEntriesBloc() : super(const LedgerEntriesState()) {
    on<CreateEntry>(_onCreateEntry);
    on<UpdateEntry>(_onUpdateEntry);
    on<DeleteEntry>(_onDeleteEntry);
    on<InitializeEntryEditMode>(_onInitializeEditMode);
    on<InitializeBookForEntry>(_onInitializeBookForEntry);
    on<EntriesNameChanged>(_onEntryNameChanged);
    on<AmountChanged>(_onAmountChanged);
    on<DateTimeChanged>(_onDateTimeChanged);
    on<TypeChanged>(_onTypeChanged);
    on<EntriesNameCompleted>(_onEntryNameCompleted);
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(dateTime);
  }

  FutureOr<void> _onEntryNameChanged(
      EntriesNameChanged event, Emitter<LedgerEntriesState> emit) {
    emit(state.copyWith(
      name: event.name,
    ));
  }

  FutureOr<void> _onEntryNameCompleted(
      EntriesNameCompleted event, Emitter<LedgerEntriesState> emit) {
    emit(state.copyWith(
      isButtonEnabled: event.isValid &&
          state.amount.isNotEmpty &&
          double.tryParse(state.amount) != null &&
          double.parse(state.amount) > 0,
    ));
  }

  FutureOr<void> _onAmountChanged(
      AmountChanged event, Emitter<LedgerEntriesState> emit) {
    final isValid = event.amount.isNotEmpty &&
        state.name.isNotEmpty &&
        double.tryParse(event.amount) != null &&
        double.parse(event.amount) > 0;

    emit(state.copyWith(
      amount: event.amount,
      isButtonEnabled: isValid,
    ));
  }

  FutureOr<void> _onDateTimeChanged(
      DateTimeChanged event, Emitter<LedgerEntriesState> emit) {
    emit(state.copyWith(
      dateTime: event.dateTime,
    ));
  }

  FutureOr<void> _onTypeChanged(
      TypeChanged event, Emitter<LedgerEntriesState> emit) {
    emit(state.copyWith(
      type: event.type,
    ));
  }

  FutureOr<void> _onInitializeEditMode(
      InitializeEntryEditMode event, Emitter<LedgerEntriesState> emit) {
    emit(state.copyWith(
      isEditMode: true,
      currentEntryId: event.entryItem.id,
      currentBookId: event.entryItem.bookId,
      name: event.entryItem.title,
      amount: event.entryItem.amount.toString(),
      type: event.entryItem.type,
      dateTime: event.entryItem.createdAt,
      isButtonEnabled: true,
    ));
  }

  FutureOr<void> _onInitializeBookForEntry(
      InitializeBookForEntry event, Emitter<LedgerEntriesState> emit) {
    emit(state.copyWith(
      currentBookId: event.bookId,
      type: event.entryType,
      isEditMode: false,
      currentEntryId: null,
      name: '',
      amount: '0',
      dateTime: _formatDateTime(DateTime.now()),
      isButtonEnabled: false,
    ));
  }

  Future<void> _onCreateEntry(
    CreateEntry event,
    Emitter<LedgerEntriesState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CreateEntriesStatus.loading));

      final request = CreateEntryRequest(
        bookId: state.currentBookId!,
        type: state.type,
        name: state.name,
        amount: double.parse(state.amount),
        currency: state.currency,
        dateTime: state.dateTime.isEmpty
            ? _formatDateTime(DateTime.now())
            : state.dateTime,
      );

      final response = await safeExecute<CreateEntryResponse>(
        function: () async {
          return await _createEntryUseCase.execute(request: request);
        },
        showLoading: true,
        showError: true,
      );

      if (response != null) {
        emit(state.copyWith(
          status: CreateEntriesStatus.success,
          currentEntryId: response.data.id,
        ));
        print(response.data.title);
        print("response.data");
        GetIt.I<LedgerBookBloc>().add(const LoadRecentBooks());
        GetIt.I<LedgerBookBloc>().add(const GetBookById());
        GetIt.I<LedgerBookBloc>().add(InsertEntryItem(response.data));
      } else {
        emit(state.copyWith(
          status: CreateEntriesStatus.failed,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: CreateEntriesStatus.failed,
      ));
    }
  }

  Future<void> _onUpdateEntry(
    UpdateEntry event,
    Emitter<LedgerEntriesState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CreateEntriesStatus.loading));

      final request = UpdateEntryRequest(
        id: state.currentEntryId!,
        type: state.type,
        name: state.name,
        amount: double.parse(state.amount),
        currency: state.currency,
        dateTime: state.dateTime.isEmpty
            ? _formatDateTime(DateTime.now())
            : state.dateTime,
      );

      final response = await safeExecute<CreateEntryResponse>(
        function: () async {
          return await _updateEntryUseCase.execute(request: request);
        },
        showLoading: true,
        showError: true,
      );

      if (response != null) {
        emit(state.copyWith(
          status: CreateEntriesStatus.success,
          currentEntryId: response.data.id,
        ));
        GetIt.I<LedgerBookBloc>().add(const LoadRecentBooks());
        GetIt.I<LedgerBookBloc>().add(const GetBookById());
        GetIt.I<LedgerBookBloc>().add(UpdateEntryItem(response.data));
      } else {
        emit(state.copyWith(
          status: CreateEntriesStatus.failed,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: CreateEntriesStatus.failed,
      ));
    }
  }

  Future<void> _onDeleteEntry(
    DeleteEntry event,
    Emitter<LedgerEntriesState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CreateEntriesStatus.loading));

      final response = await safeExecute<CreateEntryResponse>(
        function: () async {
          return await _deleteEntryUseCase.execute(request: event.entryId);
        },
        showLoading: true,
        showError: true,
      );

      if (response != null && response.success) {
        emit(state.copyWith(
          status: CreateEntriesStatus.deleteSuccess,
        ));
        if (state.currentBookId != null) {
          GetIt.I<LedgerBookBloc>()
              .add(LoadEntries(bookId: state.currentBookId!));
        }
        GetIt.I<LedgerBookBloc>().add(const LoadRecentBooks());
        GetIt.I<LedgerBookBloc>().add(const GetBookById());
        GetIt.I<RouterManager>().goRouter.pop();
      } else {
        emit(state.copyWith(
          status: CreateEntriesStatus.failed,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: CreateEntriesStatus.failed,
      ));
    }
  }
}
