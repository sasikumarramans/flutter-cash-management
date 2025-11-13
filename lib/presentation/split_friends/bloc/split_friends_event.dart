import 'package:equatable/equatable.dart';

sealed class SplitFriendsEvent extends Equatable {
  const SplitFriendsEvent();

  @override
  List<Object?> get props => [];
}

class LoadFriends extends SplitFriendsEvent {
  final bool isRefresh;
  const LoadFriends({this.isRefresh = false});
}

class LoadMoreFriends extends SplitFriendsEvent {
  const LoadMoreFriends();
}

class FilterFriendsChanged extends SplitFriendsEvent {
  final int filterIndex;
  const FilterFriendsChanged(this.filterIndex);
}

class SearchFriendsChanged extends SplitFriendsEvent {
  final String query;
  const SearchFriendsChanged(this.query);
}
