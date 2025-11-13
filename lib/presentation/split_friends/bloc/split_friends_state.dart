import 'package:bearnshare/domain/friends/model/get_friends_response.dart';
import 'package:equatable/equatable.dart';

enum SplitFriendsStatus {
  initial,
  loading,
  success,
  failed,
}

class SplitFriendsState extends Equatable {
  final List<FriendItem> friends;
  final List<FriendItem> filteredFriends;
  final SplitFriendsStatus status;
  final String? errorMessage;
  final int currentPage;
  final int totalPages;
  final bool hasMore;
  final bool isLoadingMore;
  final int selectedFilterIndex;
  final String searchQuery;

  const SplitFriendsState({
    this.friends = const [],
    this.filteredFriends = const [],
    this.status = SplitFriendsStatus.initial,
    this.errorMessage,
    this.currentPage = 0,
    this.totalPages = 0,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.selectedFilterIndex = 0,
    this.searchQuery = '',
  });

  SplitFriendsState copyWith({
    List<FriendItem>? friends,
    List<FriendItem>? filteredFriends,
    SplitFriendsStatus? status,
    String? errorMessage,
    int? currentPage,
    int? totalPages,
    bool? hasMore,
    bool? isLoadingMore,
    int? selectedFilterIndex,
    String? searchQuery,
  }) {
    return SplitFriendsState(
      friends: friends ?? this.friends,
      filteredFriends: filteredFriends ?? this.filteredFriends,
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
        friends,
        filteredFriends,
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