import 'package:bearnshare/app/bloc/base/base_bloc.dart';
import 'package:bearnshare/domain/group/model/get_groups_request.dart';
import 'package:bearnshare/domain/group/model/get_groups_response.dart';
import 'package:bearnshare/domain/group/use_cases/get_groups_use_case.dart';
import 'package:bearnshare/domain/group/use_cases/search_use_case.dart';
import 'package:bearnshare/domain/split_add/model/get_splits_request.dart';
import 'package:bearnshare/domain/split_add/model/get_splits_response.dart';
import 'package:bearnshare/domain/split_add/model/search_request.dart';
import 'package:bearnshare/domain/split_add/model/search_response.dart';
import 'package:bearnshare/domain/split_add/use_cases/get_splits_use_case.dart';
import 'package:bearnshare/presentation/split_group/bloc/split_group_event.dart';
import 'package:bearnshare/presentation/split_group/bloc/split_group_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class SplitGroupBloc extends BaseBloc<SplitGroupEvent, SplitGroupState> {
  late final _getGroupsUseCase = GetIt.I.get<GetGroupsUseCase>();
  late final _getSplitsUseCase = GetIt.I.get<GetSplitsUseCase>();
  late final _searchUseCase = GetIt.I.get<SearchUseCase>();
  CancelToken? _searchCancelToken;

  SplitGroupBloc() : super(const SplitGroupState()) {
    on<LoadGroups>(_onLoadGroups);
    on<LoadMoreGroups>(_onLoadMoreGroups);
    on<LoadExpenses>(_onLoadExpenses);
    on<LoadMoreExpenses>(_onLoadMoreExpenses);
    on<SearchMembers>(_onSearchMembers);
    on<AddMemberToSelection>(_onAddMemberToSelection);
    on<RemoveMemberFromSelection>(_onRemoveMemberFromSelection);
    on<ClearMemberSearch>(_onClearMemberSearch);
    on<FilterGroupsChanged>(_onFilterGroupsChanged);
    on<SearchGroupsChanged>(_onSearchGroupsChanged);
  }

  @override
  Future<void> close() {
    _searchCancelToken?.cancel();
    return super.close();
  }

  Future<void> _onLoadGroups(
    LoadGroups event,
    Emitter<SplitGroupState> emit,
  ) async {
    try {
      if (event.isRefresh) {
        // For pull to refresh, don't show loading state
        emit(state.copyWith(currentPage: 0, hasMore: true));
      } else {
        emit(state.copyWith(status: SplitGroupStatus.loading));
      }

      final request = GetGroupsRequest(
        page: 0,
        size: 20,
        sortBy: 'createdAt',
        sortDir: 'desc',
      );

      final response = await safeExecute<GroupsResponse>(
        function: () async {
          return await _getGroupsUseCase.execute(request: request);
        },
        showLoading: false,
        showError: true,
      );

      if (response != null && response.data.content.isNotEmpty) {
        final data = response.data.content;
        emit(state.copyWith(
          groups: data,
          status: SplitGroupStatus.success,
          hasMore: data.length == 20,
          currentPage: 0,
        ));
      } else {
        emit(state.copyWith(
          status: SplitGroupStatus.failed,
          errorMessage: 'Failed to load groups',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: SplitGroupStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadMoreGroups(
    LoadMoreGroups event,
    Emitter<SplitGroupState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMore) return;

    try {
      emit(state.copyWith(isLoadingMore: true));

      final nextPage = state.currentPage + 1;
      final request = GetGroupsRequest(
        page: nextPage,
        size: 20,
        sortBy: 'createdAt',
        sortDir: 'desc',
      );

      final response = await safeExecute<GroupsResponse>(
        function: () async {
          return await _getGroupsUseCase.execute(request: request);
        },
        showLoading: false,
        showError: true,
      );

      if (response != null && response.data.content.isNotEmpty) {
        final data = response.data.content;
        final updatedGroups = List<GroupItem>.from(state.groups)..addAll(data);

        emit(state.copyWith(
          groups: updatedGroups,
          currentPage: nextPage,
          hasMore: data.length == 20,
          isLoadingMore: false,
        ));
      } else {
        emit(state.copyWith(isLoadingMore: false));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoadingMore: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadExpenses(
    LoadExpenses event,
    Emitter<SplitGroupState> emit,
  ) async {
    try {
      if (event.isRefresh) {
        emit(state.copyWith(expensesCurrentPage: 0, expensesHasMore: true));
      } else {
        emit(state.copyWith(expensesStatus: SplitGroupStatus.loading));
      }

      final request = GetSplitsRequest(
        groupId: event.groupId,
        page: 0,
        size: 20,
        sortBy: 'createdAt',
        sortDir: 'desc',
      );

      final response = await safeExecute<GetSplitsResponse>(
        function: () async {
          return await _getSplitsUseCase.execute(request: request);
        },
        showLoading: false,
        showError: true,
      );

      if (response != null && response.content.isNotEmpty) {
        final data = response.content;
        emit(state.copyWith(
          expenses: data,
          expensesStatus: SplitGroupStatus.success,
          expensesHasMore: data.length == 20,
          expensesCurrentPage: 0,
        ));
      } else {
        emit(state.copyWith(
          expensesStatus: SplitGroupStatus.success,
          expenses: [],
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        expensesStatus: SplitGroupStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadMoreExpenses(
    LoadMoreExpenses event,
    Emitter<SplitGroupState> emit,
  ) async {
    if (state.isLoadingMoreExpenses || !state.expensesHasMore) return;

    try {
      emit(state.copyWith(isLoadingMoreExpenses: true));

      final nextPage = state.expensesCurrentPage + 1;
      final request = GetSplitsRequest(
        groupId: event.groupId,
        page: nextPage,
        size: 20,
        sortBy: 'createdAt',
        sortDir: 'desc',
      );

      final response = await safeExecute<GetSplitsResponse>(
        function: () async {
          return await _getSplitsUseCase.execute(request: request);
        },
        showLoading: false,
        showError: true,
      );

      if (response != null && response.content.isNotEmpty) {
        final data = response.content;
        final updatedExpenses = List<ExpenseItem>.from(state.expenses)
          ..addAll(data);

        emit(state.copyWith(
          expenses: updatedExpenses,
          expensesCurrentPage: nextPage,
          expensesHasMore: data.length == 20,
          isLoadingMoreExpenses: false,
        ));
      } else {
        emit(state.copyWith(isLoadingMoreExpenses: false));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoadingMoreExpenses: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onSearchMembers(
    SearchMembers event,
    Emitter<SplitGroupState> emit,
  ) async {
    _searchCancelToken?.cancel();

    /* if (event.query.trim().isEmpty) {
      emit(state.copyWith(
        searchFriends: [],
        searchGroups: [],
        searchStatus: SearchStatus.initial,
      ));
      return;
    }*/

    try {
      emit(state.copyWith(searchStatus: SearchStatus.loading));
      _searchCancelToken = CancelToken();

      final request = SearchRequest(
        query: event.query.trim(),
        friendsLimit: 10,
        groupsLimit: 10,
      );

      final response = await safeExecute<SearchResponse>(
        function: () async {
          return await _searchUseCase.execute(
            request: request,
            cancelToken: _searchCancelToken,
          );
        },
        showLoading: false,
        showError: false,
      );

      if (response != null) {
        emit(state.copyWith(
          searchFriends: response.data.friends,
          searchGroups: response.data.groups,
          searchStatus: SearchStatus.success,
        ));
      } else {
        emit(state.copyWith(
          searchFriends: [],
          searchGroups: [],
          searchStatus: SearchStatus.failed,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        searchFriends: [],
        searchGroups: [],
        searchStatus: SearchStatus.failed,
      ));
    }
  }

  void _onAddMemberToSelection(
    AddMemberToSelection event,
    Emitter<SplitGroupState> emit,
  ) {
    final isAlreadySelected =
        state.selectedMembers.any((m) => m.userId == event.member.userId);

    if (!isAlreadySelected) {
      final updatedMembers = List<FriendItem>.from(state.selectedMembers)
        ..add(event.member);
      emit(state.copyWith(selectedMembers: updatedMembers));
    }
  }

  void _onRemoveMemberFromSelection(
    RemoveMemberFromSelection event,
    Emitter<SplitGroupState> emit,
  ) {
    final updatedMembers =
        state.selectedMembers.where((m) => m.userId != event.userId).toList();
    emit(state.copyWith(selectedMembers: updatedMembers));
  }

  void _onClearMemberSearch(
    ClearMemberSearch event,
    Emitter<SplitGroupState> emit,
  ) {
    emit(state.copyWith(
      searchFriends: [],
      searchGroups: [],
      searchStatus: SearchStatus.initial,
    ));
  }

  void _onFilterGroupsChanged(
    FilterGroupsChanged event,
    Emitter<SplitGroupState> emit,
  ) {
    emit(state.copyWith(selectedFilterIndex: event.filterIndex));
    add(const LoadGroups());
  }

  void _onSearchGroupsChanged(
    SearchGroupsChanged event,
    Emitter<SplitGroupState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
  }
}
