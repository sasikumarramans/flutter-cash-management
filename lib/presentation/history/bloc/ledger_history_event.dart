import 'package:equatable/equatable.dart';

sealed class LedgerHistoryEvent extends Equatable {
  const LedgerHistoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadHistoryEntries extends LedgerHistoryEvent {
  final bool isRefresh;
  const LoadHistoryEntries({this.isRefresh = false});
}

class LoadHistoryMoreEntries extends LedgerHistoryEvent {
  const LoadHistoryMoreEntries();
}

class SearchHistoryEntriesChanged extends LedgerHistoryEvent {
  final String query;
  const SearchHistoryEntriesChanged(this.query);
}

class LoadHistoryRecentEntries extends LedgerHistoryEvent {
  const LoadHistoryRecentEntries();
}
