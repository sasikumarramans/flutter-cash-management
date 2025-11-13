import 'package:bearnshare/domain/group/model/get_groups_response.dart';
import 'package:bearnshare/domain/split_add/model/get_splits_response.dart';
import 'package:bearnshare/domain/split_add/model/search_response.dart';
import 'package:equatable/equatable.dart';

enum SplitGroupStatus {
  initial,
  loading,
  success,
  failed,
}

enum SearchStatus {
  initial,
  loading,
  success,
  failed,
}

class SplitGroupState extends Equatable {
  final List<GroupItem> groups;
  final List<ExpenseItem> expenses;
  final List<FriendItem> searchFriends;
  final List<GroupSearchItem> searchGroups;
  final List<FriendItem> selectedMembers;
  final SplitGroupStatus status;
  final SplitGroupStatus expensesStatus;
  final SearchStatus searchStatus;
  final String? errorMessage;
  final int currentPage;
  final int totalPages;
  final int expensesCurrentPage;
  final int expensesTotalPages;
  final bool hasMore;
  final bool expensesHasMore;
  final bool isLoadingMore;
  final bool isLoadingMoreExpenses;
  final int selectedFilterIndex;
  final String searchQuery;

  const SplitGroupState({
    this.groups = const [],
    this.expenses = const [],
    this.searchFriends = const [],
    this.searchGroups = const [],
    this.selectedMembers = const [],
    this.status = SplitGroupStatus.initial,
    this.expensesStatus = SplitGroupStatus.initial,
    this.searchStatus = SearchStatus.initial,
    this.errorMessage,
    this.currentPage = 0,
    this.totalPages = 0,
    this.expensesCurrentPage = 0,
    this.expensesTotalPages = 0,
    this.hasMore = true,
    this.expensesHasMore = true,
    this.isLoadingMore = false,
    this.isLoadingMoreExpenses = false,
    this.selectedFilterIndex = 0,
    this.searchQuery = '',
  });

  SplitGroupState copyWith({
    List<GroupItem>? groups,
    List<ExpenseItem>? expenses,
    List<FriendItem>? searchFriends,
    List<GroupSearchItem>? searchGroups,
    List<FriendItem>? selectedMembers,
    SplitGroupStatus? status,
    SplitGroupStatus? expensesStatus,
    SearchStatus? searchStatus,
    String? errorMessage,
    int? currentPage,
    int? totalPages,
    int? expensesCurrentPage,
    int? expensesTotalPages,
    bool? hasMore,
    bool? expensesHasMore,
    bool? isLoadingMore,
    bool? isLoadingMoreExpenses,
    int? selectedFilterIndex,
    String? searchQuery,
  }) {
    return SplitGroupState(
      groups: groups ?? this.groups,
      expenses: expenses ?? this.expenses,
      searchFriends: searchFriends ?? this.searchFriends,
      searchGroups: searchGroups ?? this.searchGroups,
      selectedMembers: selectedMembers ?? this.selectedMembers,
      status: status ?? this.status,
      expensesStatus: expensesStatus ?? this.expensesStatus,
      searchStatus: searchStatus ?? this.searchStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      expensesCurrentPage: expensesCurrentPage ?? this.expensesCurrentPage,
      expensesTotalPages: expensesTotalPages ?? this.expensesTotalPages,
      hasMore: hasMore ?? this.hasMore,
      expensesHasMore: expensesHasMore ?? this.expensesHasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isLoadingMoreExpenses:
          isLoadingMoreExpenses ?? this.isLoadingMoreExpenses,
      selectedFilterIndex: selectedFilterIndex ?? this.selectedFilterIndex,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        groups,
        expenses,
        searchFriends,
        searchGroups,
        selectedMembers,
        status,
        expensesStatus,
        searchStatus,
        errorMessage,
        currentPage,
        totalPages,
        expensesCurrentPage,
        expensesTotalPages,
        hasMore,
        expensesHasMore,
        isLoadingMore,
        isLoadingMoreExpenses,
        selectedFilterIndex,
        searchQuery,
      ];
}
