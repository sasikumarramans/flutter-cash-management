import 'package:equatable/equatable.dart';

sealed class SplitActivityEvent extends Equatable {
  const SplitActivityEvent();

  @override
  List<Object?> get props => [];
}

class LoadActivities extends SplitActivityEvent {
  final bool isRefresh;
  const LoadActivities({this.isRefresh = false});

  @override
  List<Object?> get props => [isRefresh];
}

class LoadMoreActivities extends SplitActivityEvent {
  const LoadMoreActivities();
}

class FilterActivitiesChanged extends SplitActivityEvent {
  final int filterIndex;
  const FilterActivitiesChanged(this.filterIndex);

  @override
  List<Object?> get props => [filterIndex];
}