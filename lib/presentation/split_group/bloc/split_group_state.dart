import 'package:bearnshare/domain/group/model/get_groups_response.dart';
import 'package:equatable/equatable.dart';

enum SplitGroupStatus {
  initial,
  loading,
  success,
  failed,
}

class SplitGroupState extends Equatable {
  final List<GroupItem> groups;
  final SplitGroupStatus status;
  final String? errorMessage;
  final int currentPage;
  final int totalPages;
  final bool hasMore;
  final bool isLoadingMore;
  final int selectedFilterIndex;
  final String searchQuery;

  const SplitGroupState({
    this.groups = const [],
    this.status = SplitGroupStatus.initial,
    this.errorMessage,
    this.currentPage = 0,
    this.totalPages = 0,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.selectedFilterIndex = 0,
    this.searchQuery = '',
  });

  SplitGroupState copyWith({
    List<GroupItem>? groups,
    SplitGroupStatus? status,
    String? errorMessage,
    int? currentPage,
    int? totalPages,
    bool? hasMore,
    bool? isLoadingMore,
    int? selectedFilterIndex,
    String? searchQuery,
  }) {
    return SplitGroupState(
      groups: groups ?? this.groups,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      selectedFilterIndex: selectedFilterIndex ?? this.selectedFilterIndex,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        groups,
        status,
        errorMessage,
        currentPage,
        totalPages,
        hasMore,
        isLoadingMore,
        selectedFilterIndex,
        searchQuery,
      ];
}
