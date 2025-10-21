import 'package:bearnshare/app/bloc/base/base_bloc.dart';
import 'package:bearnshare/domain/group/model/get_groups_request.dart';
import 'package:bearnshare/domain/group/model/get_groups_response.dart';
import 'package:bearnshare/domain/group/use_cases/get_groups_use_case.dart';
import 'package:bearnshare/presentation/split_group/bloc/split_group_event.dart';
import 'package:bearnshare/presentation/split_group/bloc/split_group_state.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

class SplitGroupBloc extends BaseBloc<SplitGroupEvent, SplitGroupState> {
  late final _getGroupsUseCase = GetIt.I.get<GetGroupsUseCase>();

  SplitGroupBloc() : super(const SplitGroupState()) {
    on<LoadGroups>(_onLoadGroups);
    on<LoadMoreGroups>(_onLoadMoreGroups);
    on<FilterGroupsChanged>(_onFilterGroupsChanged);
    on<SearchGroupsChanged>(_onSearchGroupsChanged);
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
