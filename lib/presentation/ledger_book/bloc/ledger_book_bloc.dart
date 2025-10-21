import 'dart:async';

import 'package:bearnshare/app/bloc/base/base_bloc.dart';
import 'package:bearnshare/domain/ledger/model/create_book_response.dart';
import 'package:bearnshare/domain/ledger/model/create_entry_response.dart';
import 'package:bearnshare/domain/ledger/model/get_books_request.dart';
import 'package:bearnshare/domain/ledger/model/get_books_response.dart';
import 'package:bearnshare/domain/ledger/model/get_dashboard_request.dart';
import 'package:bearnshare/domain/ledger/model/get_dashboard_response.dart';
import 'package:bearnshare/domain/ledger/model/get_entries_request.dart';
import 'package:bearnshare/domain/ledger/model/get_entries_response.dart';
import 'package:bearnshare/domain/ledger/model/search_books_request.dart';
import 'package:bearnshare/domain/ledger/model/search_entries_request.dart';
import 'package:bearnshare/domain/ledger/use_cases/delete_book_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/delete_entry_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/get_book_by_id_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/get_books_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/get_dashboard_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/get_entries_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/search_books_use_case.dart';
import 'package:bearnshare/domain/ledger/use_cases/search_entries_use_case.dart';
import 'package:bearnshare/presentation/create_book/bloc/create_book_bloc.dart';
import 'package:bearnshare/presentation/create_book/bloc/create_book_event.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_event.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_state.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class LedgerBookBloc extends BaseBloc<LedgerBookEvent, LedgerBookState> {
  late final _getEntriesUseCase = GetIt.I.get<GetEntriesUseCase>();
  late final _searchEntriesUseCase = GetIt.I.get<SearchEntriesUseCase>();
  late final _getBooksUseCase = GetIt.I.get<GetBooksUseCase>();
  late final _getBookByIdUseCase = GetIt.I.get<GetBookByIdUseCase>();
  late final _searchBooksUseCase = GetIt.I.get<SearchBooksUseCase>();
  late final _deleteBookUseCase = GetIt.I.get<DeleteBookUseCase>();
  late final _getDashboardUseCase = GetIt.I.get<GetDashboardUseCase>();
  CancelToken? _searchEntriesCancelToken;
  CancelToken? _searchBooksCancelToken;
  late final _deleteEntryUseCase = GetIt.I.get<DeleteEntryUseCase>();

  LedgerBookBloc() : super(const LedgerBookState()) {
    on<LoadEntries>(_onLoadEntries);
    on<LoadMoreEntries>(_onLoadMoreEntries);
    on<SearchEntriesChanged>(_onSearchEntriesChanged);
    on<LoadBooks>(_onLoadBooks);
    on<LoadRecentBooks>(_onLoadRecentBooks);
    on<LoadMoreBooks>(_onLoadMoreBooks);
    on<SearchBooksChanged>(_onSearchBooksChanged);
    on<SelectedBook>(_onSelectedBook);
    on<DeleteBook>(_onDeleteBook);
    on<KeyboardVisibilityChanged>(_onKeyboardVisibilityChangedBook);
    on<LedgerDeleteEntry>(_onDeleteEntry);
    on<UpdateEntryItem>(_onUpdateEntryItem);
    on<InsertEntryItem>(_onInsertEntryItem);
    on<UpdateBookItem>(_onUpdateBookItem);
    on<InsertBookItem>(_onInsertBookItem);
    on<GetBookById>(_onBookById);
    on<LoadDashboard>(_onLoadDashboard);
    add(const LoadRecentBooks());
    add(const LoadDashboard());
  }

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> _onBookById(
    GetBookById event,
    Emitter<LedgerBookState> emit,
  ) async {
    try {
      final response = await safeExecute<CreateBookResponse>(
        function: () async {
          return await _getBookByIdUseCase.execute(
              request: state.selectedBookItem!.id);
        },
        showLoading: false,
        showError: true,
      );

      if (response != null) {
        final data = response.data;
        emit(state.copyWith(selectedBookItem: data));
      }
    } catch (e) {
      //
    }
  }

  Future<void> _onDeleteEntry(
    LedgerDeleteEntry event,
    Emitter<LedgerBookState> emit,
  ) async {
    try {
      final response = await safeExecute<CreateEntryResponse>(
        function: () async {
          return await _deleteEntryUseCase.execute(request: event.entryId);
        },
        showLoading: true,
        showError: true,
      );

      if (response != null && response.success) {
        add(const LoadRecentBooks());
        GetIt.I<LedgerBookBloc>()
            .add(LoadEntries(bookId: state.selectedBookItem?.id ?? 0));
      }
    } catch (e) {
      //
    }
  }

  void _onUpdateEntryItem(
    UpdateEntryItem event,
    Emitter<LedgerBookState> emit,
  ) {
    final updatedEntries = state.entries.map((entry) {
      if (entry.id == event.updatedEntry.id) {
        return event.updatedEntry;
      }
      return entry;
    }).toList();
    emit(state.copyWith(entries: updatedEntries));
  }

  void _onInsertEntryItem(
    InsertEntryItem event,
    Emitter<LedgerBookState> emit,
  ) {
    print(event.newEntry.title);
    print("event.newEntry.name");
    final updatedEntries = [event.newEntry, ...state.entries];
    emit(state.copyWith(
      entries: updatedEntries,
      totalElements: state.totalElements + 1,
    ));
  }

  void _onUpdateBookItem(
    UpdateBookItem event,
    Emitter<LedgerBookState> emit,
  ) {
    final updatedBooks = state.books.map((book) {
      if (book.id == event.updatedBook.id) {
        return event.updatedBook;
      }
      return book;
    }).toList();

    // Also update selectedBookItem if it's the same book
    final updatedSelectedBook =
        state.selectedBookItem?.id == event.updatedBook.id
            ? event.updatedBook
            : state.selectedBookItem;

    emit(state.copyWith(
      books: updatedBooks,
      selectedBookItem: updatedSelectedBook,
    ));
  }

  void _onInsertBookItem(
    InsertBookItem event,
    Emitter<LedgerBookState> emit,
  ) {
    final updatedBooks = [event.newBook, ...state.books];
    emit(state.copyWith(books: updatedBooks));
  }

  void _onKeyboardVisibilityChangedBook(
    KeyboardVisibilityChanged event,
    Emitter<LedgerBookState> emit,
  ) {
    emit(state.copyWith(isKeyboardVisible: event.isKeyBoardVisible));
  }

  void _onSelectedBook(
    SelectedBook event,
    Emitter<LedgerBookState> emit,
  ) {
    emit(state.copyWith(selectedBookItem: event.booksItem));
  }

  Future<void> _onLoadEntries(
    LoadEntries event,
    Emitter<LedgerBookState> emit,
  ) async {
    try {
      if (event.isRefresh) {
        emit(state.copyWith(
          currentPage: 0,
          hasMore: true,
          currentBookId: event.bookId,
        ));
      } else {
        emit(state.copyWith(
          status: LedgerBookStatus.loading,
          currentBookId: event.bookId,
        ));
      }

      final request = GetEntriesRequest(
        bookId: state.selectedBookItem?.id ?? 0,
        page: 0,
        size: 20,
        sortBy: 'createdAt',
        sortDir: 'desc',
      );

      final response = await safeExecute<EntriesData>(
        function: () async {
          return await _getEntriesUseCase.execute(request: request);
        },
        showLoading: false,
        showError: true,
      );

      if (response != null && response.content.isNotEmpty) {
        final data = response.content;
        emit(state.copyWith(
          entries: data,
          status: LedgerBookStatus.success,
          hasMore: data.length == 20,
          currentPage: 0,
          totalElements: response.totalElements,
          totalPages: response.totalPages,
          currentBookId: event.bookId,
        ));
      } else {
        emit(state.copyWith(
          entries: [],
          status: LedgerBookStatus.success,
          hasMore: false,
          currentPage: 0,
          totalElements: 0,
          currentBookId: event.bookId,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: LedgerBookStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadMoreEntries(
    LoadMoreEntries event,
    Emitter<LedgerBookState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMore) {
      return;
    }

    try {
      emit(state.copyWith(isLoadingMore: true));

      final nextPage = state.currentPage + 1;
      final isSearchMode = state.searchQuery.isNotEmpty;
      EntriesData? response;
      if (isSearchMode) {
        final searchRequest = SearchEntriesRequest(
          query: state.searchQuery,
          page: nextPage,
          size: 20,
          bookId: state.selectedBookItem?.id ?? 0,
        );

        response = await safeExecute<EntriesData>(
          function: () async {
            return await _searchEntriesUseCase.execute(
              request: searchRequest,
              cancelToken: _searchEntriesCancelToken,
            );
          },
          showLoading: false,
          showError: true,
        );
      } else {
        // Load more regular entries
        final request = GetEntriesRequest(
          bookId: state.selectedBookItem?.id ?? 0,
          page: nextPage,
          size: 20,
          sortBy: 'createdAt',
          sortDir: 'desc',
        );

        response = await safeExecute<EntriesData>(
          function: () async {
            return await _getEntriesUseCase.execute(request: request);
          },
          showLoading: false,
          showError: true,
        );
      }

      if (response != null && response.content.isNotEmpty) {
        final data = response.content;
        final updatedEntries = List<EntryItem>.from(state.entries)
          ..addAll(data);

        emit(state.copyWith(
          entries: updatedEntries,
          currentPage: nextPage,
          totalElements: response.totalElements,
          hasMore: data.length == 20,
          isLoadingMore: false,
        ));
      } else {
        emit(state.copyWith(
            isLoadingMore: false, hasMore: false, totalElements: 0));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoadingMore: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onSearchEntriesChanged(
    SearchEntriesChanged event,
    Emitter<LedgerBookState> emit,
  ) async {
    emit(state.copyWith(searchQuery: event.query));
    if (event.query.isEmpty) {
      add(LoadEntries(
          bookId: state.selectedBookItem?.id ?? 0, isRefresh: true));
      return;
    }
    await _performSearch(event.query, emit);
  }

  Future<void> _performSearch(
    String query,
    Emitter<LedgerBookState> emit,
  ) async {
    try {
      _searchEntriesCancelToken?.cancel();
      _searchEntriesCancelToken = CancelToken();
      emit(state.copyWith(
        status: LedgerBookStatus.loading,
        currentPage: 0,
        hasMore: true,
      ));

      final request = SearchEntriesRequest(
          query: query,
          page: 0,
          size: 20,
          bookId: state.selectedBookItem?.id ?? 0);

      final response = await safeExecute<EntriesData>(
        function: () async {
          return await _searchEntriesUseCase.execute(
            request: request,
            cancelToken: _searchEntriesCancelToken,
          );
        },
        showLoading: false,
        showError: true,
      );

      if (response != null) {
        emit(state.copyWith(
          entries: response.content,
          status: LedgerBookStatus.success,
          hasMore: response.content.length == 20,
          currentPage: 0,
          totalElements: response.totalElements,
          totalPages: response.totalPages,
        ));
      } else {
        emit(state.copyWith(
          entries: [],
          status: LedgerBookStatus.success,
          hasMore: false,
          totalElements: 0,
          currentPage: 0,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: LedgerBookStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadRecentBooks(
    LoadRecentBooks event,
    Emitter<LedgerBookState> emit,
  ) async {
    try {
      final request = GetBooksRequest(
        page: 0,
        size: 4,
        sortBy: 'createdAt',
        sortDir: 'desc',
      );

      final response = await safeExecute<BooksResponse>(
        function: () async {
          return await _getBooksUseCase.execute(request: request);
        },
        showLoading: false,
        showError: true,
      );

      if (response != null && response.data.content.isNotEmpty) {
        final data = response.data.content;
        emit(state.copyWith(
          recentBooks: data,
        ));
      }
    } catch (e) {
      //
    }
  }

  Future<void> _onLoadBooks(
    LoadBooks event,
    Emitter<LedgerBookState> emit,
  ) async {
    try {
      if (event.isRefresh) {
        emit(state.copyWith(
          booksCurrentPage: 0,
          booksHasMore: true,
        ));
      } else {
        emit(state.copyWith(status: LedgerBookStatus.loading));
      }

      final request = GetBooksRequest(
        page: 0,
        size: 20,
        sortBy: 'createdAt',
        sortDir: 'desc',
      );

      final response = await safeExecute<BooksResponse>(
        function: () async {
          return await _getBooksUseCase.execute(request: request);
        },
        showLoading: false,
        showError: true,
      );

      if (response != null && response.data.content.isNotEmpty) {
        BooksItem? booksItem = response.data.content
            .firstWhereOrNull((test) => test.id == state.selectedBookItem?.id);

        final data = response.data.content;
        emit(state.copyWith(
            books: data,
            status: LedgerBookStatus.success,
            booksHasMore: data.length == 20,
            booksCurrentPage: 0,
            booksTotalPages: response.data.totalPages,
            selectedBookItem:
                state.selectedBookItem == null || booksItem == null
                    ? data[0]
                    : null));
      } else {
        emit(state.copyWith(
          books: [],
          status: LedgerBookStatus.success,
          booksHasMore: false,
          booksCurrentPage: 0,
        ));
        GetIt.I.get<CreateBookBloc>().add(const CreateBook());
      }
    } catch (e) {
      emit(state.copyWith(
        status: LedgerBookStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadMoreBooks(
    LoadMoreBooks event,
    Emitter<LedgerBookState> emit,
  ) async {
    if (state.isLoadingMoreBooks || !state.booksHasMore) {
      return;
    }

    try {
      emit(state.copyWith(isLoadingMoreBooks: true));

      final nextPage = state.booksCurrentPage + 1;
      final isSearchMode = state.booksSearchQuery.isNotEmpty;

      BooksResponse? response;

      if (isSearchMode) {
        final searchRequest = SearchBooksRequest(
          query: state.booksSearchQuery,
          page: nextPage,
          size: 20,
        );

        response = await safeExecute<BooksResponse>(
          function: () async {
            return await _searchBooksUseCase.execute(
              request: searchRequest,
              cancelToken: _searchBooksCancelToken,
            );
          },
          showLoading: false,
          showError: true,
        );
      } else {
        // Load more regular books
        final request = GetBooksRequest(
          page: nextPage,
          size: 20,
          sortBy: 'createdAt',
          sortDir: 'desc',
        );

        response = await safeExecute<BooksResponse>(
          function: () async {
            return await _getBooksUseCase.execute(request: request);
          },
          showLoading: false,
          showError: true,
        );
      }

      if (response != null && response.data.content.isNotEmpty) {
        final data = response.data.content;
        final updatedBooks = List<BooksItem>.from(state.books)..addAll(data);

        emit(state.copyWith(
          books: updatedBooks,
          booksCurrentPage: nextPage,
          booksHasMore: data.length == 20,
          isLoadingMoreBooks: false,
        ));
      } else {
        emit(state.copyWith(
          isLoadingMoreBooks: false,
          booksHasMore: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoadingMoreBooks: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onSearchBooksChanged(
    SearchBooksChanged event,
    Emitter<LedgerBookState> emit,
  ) async {
    emit(state.copyWith(booksSearchQuery: event.query));

    if (event.query.isEmpty) {
      add(const LoadBooks(isRefresh: true));
      return;
    }

    await _performBooksSearch(event.query, emit);
  }

  Future<void> _performBooksSearch(
    String query,
    Emitter<LedgerBookState> emit,
  ) async {
    try {
      _searchBooksCancelToken?.cancel();
      _searchBooksCancelToken = CancelToken();
      emit(state.copyWith(
        status: LedgerBookStatus.loading,
        booksCurrentPage: 0,
        booksHasMore: true,
      ));

      final request = SearchBooksRequest(
        query: query,
        page: 0,
        size: 20,
      );

      final response = await safeExecute<BooksResponse>(
        function: () async {
          return await _searchBooksUseCase.execute(
            request: request,
            cancelToken: _searchBooksCancelToken,
          );
        },
        showLoading: false,
        showError: true,
      );

      if (response != null) {
        emit(state.copyWith(
          books: response.data.content,
          status: LedgerBookStatus.success,
          booksHasMore: response.data.content.length == 20,
          booksCurrentPage: 0,
          booksTotalPages: response.data.totalPages,
        ));
      } else {
        emit(state.copyWith(
          books: [],
          status: LedgerBookStatus.success,
          booksHasMore: false,
          booksCurrentPage: 0,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: LedgerBookStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onDeleteBook(
    DeleteBook event,
    Emitter<LedgerBookState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: LedgerBookStatus.loading,
      ));
      final success = await safeExecute<CreateBookResponse>(
        function: () async {
          return await _deleteBookUseCase.execute(request: event.bookId);
        },
        showLoading: true,
        showError: true,
      );
      if (success == null) {
        emit(state.copyWith(
          status: LedgerBookStatus.failed,
        ));
      }
      add(const LoadRecentBooks());
      emit(state.copyWith(
        status: LedgerBookStatus.success,
      ));
      add(const LoadBooks());
    } catch (e) {
      emit(state.copyWith(
        status: LedgerBookStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadDashboard(
    LoadDashboard event,
    Emitter<LedgerBookState> emit,
  ) async {
    try {
      final request = GetDashboardRequest(
        goalAmount: event.goalAmount,
      );

      final response = await safeExecute<DashboardResponse>(
        function: () async {
          return await _getDashboardUseCase.execute(request: request);
        },
        showLoading: false,
        showError: false,
      );

      if (response != null) {
        emit(state.copyWith(
          dashboardData: response.data,
        ));
      }
    } catch (e) {
      //
    }
  }
}
