import 'dart:async';

import 'package:bearnshare/app/bloc/base/base_bloc.dart';
import 'package:bearnshare/app/helpers/extensions/string_extensions.dart';
import 'package:bearnshare/domain/ledger/model/create_book_request.dart';
import 'package:bearnshare/domain/ledger/model/create_book_response.dart';
import 'package:bearnshare/domain/ledger/model/edit_book_request.dart';
import 'package:bearnshare/domain/ledger/use_cases/create_book_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/edit_book_use_case.dart';
import 'package:bearnshare/presentation/create_book/bloc/create_book_event.dart';
import 'package:bearnshare/presentation/create_book/bloc/create_book_state.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_bloc.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_event.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

class CreateBookBloc extends BaseBloc<CreateBookEvent, CreateBookState> {
  late final _createBookUseCase = GetIt.I.get<CreateBookUseCase>();
  late final _editBookUseCase = GetIt.I.get<EditBookUseCase>();

  CreateBookBloc() : super(const CreateBookState()) {
    on<CreateBook>(_onCreateBook);
    on<InitBook>(_onInitBook);
    on<EditBook>(_onEditBook);
    on<InitializeEditMode>(_onInitializeEditMode);
    on<BookNameChanged>(_onBookNameChanged);
    on<BookNameCompleted>(_onBookNameCompleted);
    on<BookDescChanged>(_onBookDescChanged);
  }

  FutureOr<void> _onBookNameChanged(
      BookNameChanged event, Emitter<CreateBookState> emit) {
    emit(state.copyWith(
      bookName: event.name,
    ));
  }

  FutureOr<void> _onInitBook(InitBook event, Emitter<CreateBookState> emit) {
    emit(state.copyWith(
      status: CreateBookStatus.initial,
    ));
  }

  FutureOr<void> _onBookNameCompleted(
      BookNameCompleted event, Emitter<CreateBookState> emit) {
    emit(state.copyWith(
      isButtonEnabled: event.isValid,
    ));
  }

  FutureOr<void> _onBookDescChanged(
      BookDescChanged event, Emitter<CreateBookState> emit) {
    emit(state.copyWith(
      bookDescription: event.desc,
    ));
  }

  FutureOr<void> _onInitializeEditMode(
      InitializeEditMode event, Emitter<CreateBookState> emit) {
    emit(state.copyWith(
      isEditMode: true,
      currentBookId: event.bookItem.id,
      bookName: event.bookItem.name,
      bookDescription: event.bookItem.description,
      currency: event.bookItem.currency,
      isButtonEnabled: true,
    ));
  }

  Future<void> _onCreateBook(
    CreateBook event,
    Emitter<CreateBookState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CreateBookStatus.loading));

      final request = CreateBookRequest(
        name: state.bookName.isNullOrEmpty ? "Home Expense" : state.bookName,
        description: state.bookDescription.isNullOrEmpty
            ? "home Expense"
            : state.bookDescription,
        currency: state.currency,
      );

      final response = await safeExecute<CreateBookResponse>(
        function: () async {
          return await _createBookUseCase.execute(request: request);
        },
        showLoading: true,
        showError: true,
      );

      if (response != null) {
        emit(state.copyWith(
          status: CreateBookStatus.success,
          currentBookId: response.data.id,
        ));

        GetIt.I.get<LedgerBookBloc>().add(const LoadRecentBooks());
        GetIt.I<LedgerBookBloc>().add(InsertBookItem(response.data));
        GetIt.I<LedgerBookBloc>().add(SelectedBook(response.data));
        GetIt.I<LedgerBookBloc>().add(LoadEntries(bookId: response.data.id));
      } else {
        emit(state.copyWith(
          status: CreateBookStatus.failed,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: CreateBookStatus.failed,
      ));
    }
  }

  Future<void> _onEditBook(
    EditBook event,
    Emitter<CreateBookState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CreateBookStatus.loading));

      final request = EditBookRequest(
        id: state.currentBookId!,
        name: state.bookName,
        description: state.bookDescription,
        currency: state.currency,
      );

      final response = await safeExecute<CreateBookResponse>(
        function: () async {
          return await _editBookUseCase.execute(request: request);
        },
        showLoading: true,
        showError: true,
      );

      if (response != null) {
        emit(state.copyWith(
          status: CreateBookStatus.success,
          currentBookId: response.data.id,
        ));
        GetIt.I<LedgerBookBloc>().add(UpdateBookItem(response.data));
      } else {
        emit(state.copyWith(
          status: CreateBookStatus.failed,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: CreateBookStatus.failed,
      ));
    }
  }
}
