import 'package:bearnshare/domain/split_add/model/search_response.dart';
import 'package:equatable/equatable.dart';

sealed class SplitGroupEvent extends Equatable {
  const SplitGroupEvent();

  @override
  List<Object?> get props => [];
}

class LoadGroups extends SplitGroupEvent {
  final bool isRefresh;
  const LoadGroups({this.isRefresh = false});

  @override
  List<Object?> get props => [isRefresh];
}

class LoadMoreGroups extends SplitGroupEvent {
  const LoadMoreGroups();
}

class LoadExpenses extends SplitGroupEvent {
  final int groupId;
  final bool isRefresh;
  const LoadExpenses(this.groupId, {this.isRefresh = false});

  @override
  List<Object?> get props => [groupId, isRefresh];
}

class LoadMoreExpenses extends SplitGroupEvent {
  final int groupId;
  const LoadMoreExpenses(this.groupId);

  @override
  List<Object?> get props => [groupId];
}

class SearchMembers extends SplitGroupEvent {
  final String query;
  const SearchMembers(this.query);

  @override
  List<Object?> get props => [query];
}

class AddMemberToSelection extends SplitGroupEvent {
  final FriendItem member;
  const AddMemberToSelection(this.member);

  @override
  List<Object?> get props => [member];
}

class RemoveMemberFromSelection extends SplitGroupEvent {
  final String userId;
  const RemoveMemberFromSelection(this.userId);

  @override
  List<Object?> get props => [userId];
}

class ClearMemberSearch extends SplitGroupEvent {
  const ClearMemberSearch();
}

class FilterGroupsChanged extends SplitGroupEvent {
  final int filterIndex;
  const FilterGroupsChanged(this.filterIndex);

  @override
  List<Object?> get props => [filterIndex];
}

class SearchGroupsChanged extends SplitGroupEvent {
  final String query;
  const SearchGroupsChanged(this.query);

  @override
  List<Object?> get props => [query];
}
