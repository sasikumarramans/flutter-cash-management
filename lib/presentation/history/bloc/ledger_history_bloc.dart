import 'dart:async';

import 'package:bearnshare/app/bloc/base/base_bloc.dart';
import 'package:bearnshare/domain/ledger/model/get_entries_response.dart';
import 'package:bearnshare/domain/ledger/model/get_recent_entries_request.dart';
import 'package:bearnshare/domain/ledger/use_cases/get_recent_entries_use_case.dart';
import 'package:bearnshare/presentation/history/bloc/ledger_history_event.dart';
import 'package:bearnshare/presentation/history/bloc/ledger_history_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class LedgerHistoryBloc
    extends BaseBloc<LedgerHistoryEvent, LedgerHistoryState> {
  late final _getRecentEntriesUseCase = GetIt.I.get<GetRecentEntriesUseCase>();
  CancelToken? _searchCancelToken;

  LedgerHistoryBloc() : super(const LedgerHistoryState()) {
    on<LoadHistoryEntries>(_onLoadHistoryEntries);
    on<LoadHistoryMoreEntries>(_onLoadHistoryMoreEntries);
    on<LoadHistoryRecentEntries>(_onLoadRecentHistoryEntries);
    on<SearchHistoryEntriesChanged>(_onSearchHistoryEntriesChanged);
  }

  @override
  Future<void> close() {
    _searchCancelToken?.cancel();
    return super.close();
  }

  Future<void> _onLoadHistoryEntries(
    LoadHistoryEntries event,
    Emitter<LedgerHistoryState> emit,
  ) async {
    try {
      if (event.isRefresh) {
        emit(state.copyWith(
          currentPage: 0,
          hasMore: true,
        ));
      } else {
        emit(state.copyWith(
          status: LedgerHistoryStatus.loading,
        ));
      }

      final request = GetRecentEntriesRequest(
        query: state.searchQuery.isEmpty ? null : state.searchQuery,
        page: 0,
        size: 20,
      );

      final response = await safeExecute<EntriesData>(
        function: () async {
          return await _getRecentEntriesUseCase.execute(
            request: request,
            cancelToken: _searchCancelToken,
          );
        },
        showLoading: false,
        showError: true,
      );

      if (response != null && response.content.isNotEmpty) {
        final data = response.content;
        emit(state.copyWith(
          entries: data,
          status: LedgerHistoryStatus.success,
          hasMore: data.length == 20,
          currentPage: 0,
          totalElements: response.totalElements,
          totalPages: response.totalPages,
        ));
      } else {
        emit(state.copyWith(
          entries: [],
          status: LedgerHistoryStatus.success,
          hasMore: false,
          currentPage: 0,
          totalElements: 0,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: LedgerHistoryStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadRecentHistoryEntries(
    LoadHistoryRecentEntries event,
    Emitter<LedgerHistoryState> emit,
  ) async {
    try {
      final request = GetRecentEntriesRequest(
        query: state.searchQuery.isEmpty ? null : state.searchQuery,
        page: 0,
        size: 8,
      );

      final response = await safeExecute<EntriesData>(
        function: () async {
          return await _getRecentEntriesUseCase.execute(
            request: request,
            cancelToken: _searchCancelToken,
          );
        },
        showLoading: false,
        showError: true,
      );

      if (response != null && response.content.isNotEmpty) {
        final data = response.content;
        emit(state.copyWith(
          recentEntries: data,
        ));
      } else {
        emit(state.copyWith(
          recentEntries: [],
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadHistoryMoreEntries(
    LoadHistoryMoreEntries event,
    Emitter<LedgerHistoryState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMore) {
      return;
    }

    try {
      emit(state.copyWith(isLoadingMore: true));

      final nextPage = state.currentPage + 1;
      final request = GetRecentEntriesRequest(
        query: state.searchQuery.isEmpty ? null : state.searchQuery,
        page: nextPage,
        size: 20,
      );

      final response = await safeExecute<EntriesData>(
        function: () async {
          return await _getRecentEntriesUseCase.execute(
            request: request,
            cancelToken: _searchCancelToken,
          );
        },
        showLoading: false,
        showError: true,
      );

      if (response != null && response.content.isNotEmpty) {
        final data = response.content;
        final updatedEntries = List<EntryItem>.from(state.entries)
          ..addAll(data);

        emit(state.copyWith(
          entries: updatedEntries,
          currentPage: nextPage,
          totalElements: response.totalElements,
          hasMore: data.length == 20,
          isLoadingMore: false,
        ));
      } else {
        emit(state.copyWith(
            isLoadingMore: false, hasMore: false, totalElements: 0));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoadingMore: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onSearchHistoryEntriesChanged(
    SearchHistoryEntriesChanged event,
    Emitter<LedgerHistoryState> emit,
  ) async {
    emit(state.copyWith(searchQuery: event.query, entries: []));
    await _performSearch(emit);
  }

  Future<void> _performSearch(
    Emitter<LedgerHistoryState> emit,
  ) async {
    try {
      _searchCancelToken?.cancel();
      _searchCancelToken = CancelToken();

      emit(state.copyWith(
        status: LedgerHistoryStatus.loading,
        currentPage: 0,
        hasMore: true,
      ));

      final request = GetRecentEntriesRequest(
        query: state.searchQuery.isEmpty ? null : state.searchQuery,
        page: 0,
        size: 20,
      );

      final response = await safeExecute<EntriesData>(
        function: () async {
          return await _getRecentEntriesUseCase.execute(
            request: request,
            cancelToken: _searchCancelToken,
          );
        },
        showLoading: false,
        showError: true,
      );

      if (response != null && response.content.isNotEmpty) {
        emit(state.copyWith(
          entries: response.content,
          status: LedgerHistoryStatus.success,
          hasMore: response.content.length == 20,
          currentPage: 0,
          totalElements: response.totalElements,
          totalPages: response.totalPages,
        ));
      } else {
        emit(state.copyWith(
          entries: [],
          status: LedgerHistoryStatus.success,
          hasMore: false,
          totalElements: 0,
          currentPage: 0,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: LedgerHistoryStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }
}
