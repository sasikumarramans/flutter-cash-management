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
