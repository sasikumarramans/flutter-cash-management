import 'package:bearnshare/domain/ledger/model/get_entries_response.dart';
import 'package:equatable/equatable.dart';

enum LedgerHistoryStatus {
  initial,
  loading,
  success,
  failed,
}

class LedgerHistoryState extends Equatable {
  final List<EntryItem> entries;
  final List<EntryItem> recentEntries;
  final LedgerHistoryStatus status;
  final String? errorMessage;
  final int currentPage;
  final int totalPages;
  final int totalElements;
  final bool hasMore;
  final bool isLoadingMore;
  final String searchQuery;

  const LedgerHistoryState({
    this.entries = const [],
    this.recentEntries = const [],
    this.status = LedgerHistoryStatus.initial,
    this.errorMessage,
    this.currentPage = 0,
    this.totalPages = 0,
    this.totalElements = 0,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.searchQuery = '',
  });

  LedgerHistoryState copyWith({
    List<EntryItem>? entries,
    List<EntryItem>? recentEntries,
    LedgerHistoryStatus? status,
    String? errorMessage,
    int? currentPage,
    int? totalPages,
    int? totalElements,
    bool? hasMore,
    bool? isLoadingMore,
    String? searchQuery,
  }) {
    return LedgerHistoryState(
      entries: entries ?? this.entries,
      recentEntries: recentEntries ?? this.recentEntries,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalElements: totalElements ?? this.totalElements,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        recentEntries,
        entries,
        status,
        errorMessage,
        currentPage,
        totalPages,
        totalElements,
        hasMore,
        isLoadingMore,
        searchQuery,
      ];
}
