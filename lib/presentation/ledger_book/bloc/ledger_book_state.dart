import 'package:bearnshare/domain/ledger/model/get_books_response.dart';
import 'package:bearnshare/domain/ledger/model/get_dashboard_response.dart';
import 'package:bearnshare/domain/ledger/model/get_entries_response.dart';
import 'package:equatable/equatable.dart';

enum LedgerBookStatus {
  initial,
  loading,
  success,
  failed,
}

class LedgerBookState extends Equatable {
  final List<EntryItem> entries;
  final List<BooksItem> books;
  final List<BooksItem> recentBooks;
  final LedgerBookStatus status;
  final String? errorMessage;
  final int currentPage;
  final int totalPages;
  final bool hasMore;
  final bool isLoadingMore;
  final String searchQuery;
  final EntriesSummary? summary;
  // Books pagination
  final int booksCurrentPage;
  final int booksTotalPages;
  final int totalElements;
  final bool booksHasMore;
  final bool isLoadingMoreBooks;
  final bool isKeyboardVisible;
  final String booksSearchQuery;
  final BooksItem? selectedBookItem;
  final DashboardData? dashboardData;

  const LedgerBookState({
    this.entries = const [],
    this.books = const [],
    this.recentBooks = const [],
    this.status = LedgerBookStatus.initial,
    this.errorMessage,
    this.currentPage = 0,
    this.totalPages = 0,
    this.totalElements = 0,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.searchQuery = '',
    this.summary,
    this.booksCurrentPage = 0,
    this.booksTotalPages = 0,
    this.booksHasMore = true,
    this.isLoadingMoreBooks = false,
    this.isKeyboardVisible = false,
    this.booksSearchQuery = '',
    this.selectedBookItem,
    this.dashboardData,
  });

  LedgerBookState copyWith({
    List<EntryItem>? entries,
    List<BooksItem>? books,
    List<BooksItem>? recentBooks,
    LedgerBookStatus? status,
    String? errorMessage,
    int? currentPage,
    int? totalPages,
    int? totalElements,
    bool? hasMore,
    bool? isLoadingMore,
    String? searchQuery,
    EntriesSummary? summary,
    int? currentBookId,
    int? booksCurrentPage,
    int? booksTotalPages,
    bool? booksHasMore,
    bool? isLoadingMoreBooks,
    bool? isKeyboardVisible,
    String? booksSearchQuery,
    String? bookDescription,
    BooksItem? selectedBookItem,
    DashboardData? dashboardData,
  }) {
    return LedgerBookState(
      entries: entries ?? this.entries,
      books: books ?? this.books,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      searchQuery: searchQuery ?? this.searchQuery,
      summary: summary ?? this.summary,
      booksCurrentPage: booksCurrentPage ?? this.booksCurrentPage,
      booksTotalPages: booksTotalPages ?? this.booksTotalPages,
      booksHasMore: booksHasMore ?? this.booksHasMore,
      isLoadingMoreBooks: isLoadingMoreBooks ?? this.isLoadingMoreBooks,
      booksSearchQuery: booksSearchQuery ?? this.booksSearchQuery,
      selectedBookItem: selectedBookItem ?? this.selectedBookItem,
      isKeyboardVisible: isKeyboardVisible ?? this.isKeyboardVisible,
      totalElements: totalElements ?? this.totalElements,
      recentBooks: recentBooks ?? this.recentBooks,
      dashboardData: dashboardData ?? this.dashboardData,
    );
  }

  @override
  List<Object?> get props => [
        entries,
        books,
        status,
        errorMessage,
        currentPage,
        totalPages,
        hasMore,
        isLoadingMore,
        searchQuery,
        summary,
        booksCurrentPage,
        booksTotalPages,
        booksHasMore,
        isLoadingMoreBooks,
        booksSearchQuery,
        selectedBookItem,
        isKeyboardVisible,
        totalElements,
        recentBooks,
        dashboardData,
      ];
}
