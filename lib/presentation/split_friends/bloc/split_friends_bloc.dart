import 'package:bearnshare/app/bloc/base/base_bloc.dart';
import 'package:bearnshare/domain/friends/model/get_friends_request.dart';
import 'package:bearnshare/domain/friends/model/get_friends_response.dart';
import 'package:bearnshare/domain/friends/use_cases/get_friends_use_case.dart';
import 'package:bearnshare/presentation/split_friends/bloc/split_friends_event.dart';
import 'package:bearnshare/presentation/split_friends/bloc/split_friends_state.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

class SplitFriendsBloc extends BaseBloc<SplitFriendsEvent, SplitFriendsState> {
  late final _getFriendsUseCase = GetIt.I.get<GetFriendsUseCase>();

  SplitFriendsBloc() : super(const SplitFriendsState()) {
    on<LoadFriends>(_onLoadFriends);
    on<LoadMoreFriends>(_onLoadMoreFriends);
    on<FilterFriendsChanged>(_onFilterFriendsChanged);
    on<SearchFriendsChanged>(_onSearchFriendsChanged);
  }

  Future<void> _onLoadFriends(
    LoadFriends event,
    Emitter<SplitFriendsState> emit,
  ) async {
    try {
      if (event.isRefresh) {
        // For pull to refresh, don't show loading state
        emit(state.copyWith(currentPage: 0, hasMore: true));
      } else {
        emit(state.copyWith(status: SplitFriendsStatus.loading));
      }

      final request = GetFriendsRequest(
        page: 0,
        size: 20,
      );

      final response = await safeExecute<FriendsResponse>(
        function: () async {
          return await _getFriendsUseCase.execute(request: request);
        },
        showLoading: false,
        showError: true,
      );

      if (response != null && response.data.content.isNotEmpty) {
        final data = response.data.content;
        final filteredData = _applyFilter(data, state.selectedFilterIndex);

        emit(state.copyWith(
          friends: data,
          filteredFriends: filteredData,
          status: SplitFriendsStatus.success,
          hasMore: data.length == 20,
          currentPage: 0,
          totalPages: response.data.totalPages,
        ));
      } else {
        emit(state.copyWith(
          status: SplitFriendsStatus.success,
          friends: [],
          filteredFriends: [],
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: SplitFriendsStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadMoreFriends(
    LoadMoreFriends event,
    Emitter<SplitFriendsState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMore) return;

    try {
      emit(state.copyWith(isLoadingMore: true));

      final nextPage = state.currentPage + 1;
      final request = GetFriendsRequest(
        page: nextPage,
        size: 20,
      );

      final response = await safeExecute<FriendsResponse>(
        function: () async {
          return await _getFriendsUseCase.execute(request: request);
        },
        showLoading: false,
        showError: true,
      );

      if (response != null && response.data.content.isNotEmpty) {
        final data = response.data.content;
        final updatedFriends = List<FriendItem>.from(state.friends)
          ..addAll(data);
        final filteredData = _applyFilter(updatedFriends, state.selectedFilterIndex);

        emit(state.copyWith(
          friends: updatedFriends,
          filteredFriends: filteredData,
          currentPage: nextPage,
          hasMore: data.length == 20,
          isLoadingMore: false,
          totalPages: response.data.totalPages,
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

  void _onFilterFriendsChanged(
    FilterFriendsChanged event,
    Emitter<SplitFriendsState> emit,
  ) {
    final filteredData = _applyFilter(state.friends, event.filterIndex);
    emit(state.copyWith(
      selectedFilterIndex: event.filterIndex,
      filteredFriends: filteredData,
    ));
  }

  void _onSearchFriendsChanged(
    SearchFriendsChanged event,
    Emitter<SplitFriendsState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));

    if (event.query.trim().isEmpty) {
      final filteredData = _applyFilter(state.friends, state.selectedFilterIndex);
      emit(state.copyWith(filteredFriends: filteredData));
    } else {
      final searchResults = state.friends.where((friend) {
        final query = event.query.toLowerCase();
        return friend.name.toLowerCase().contains(query) ||
            friend.username.toLowerCase().contains(query) ||
            friend.email.toLowerCase().contains(query);
      }).toList();

      final filteredData = _applyFilter(searchResults, state.selectedFilterIndex);
      emit(state.copyWith(filteredFriends: filteredData));
    }
  }

  List<FriendItem> _applyFilter(List<FriendItem> friends, int filterIndex) {
    switch (filterIndex) {
      case 0: // All
        return friends;
      case 1: // Active (friends who owe you or you owe them)
        return friends.where((friend) {
          return friend.overallPayingAmount > 0 ||
                 friend.overallReceivingAmount > 0;
        }).toList();
      case 2: // Settled (friends with no outstanding balance)
        return friends.where((friend) {
          return friend.overallPayingAmount == 0 &&
                 friend.overallReceivingAmount == 0;
        }).toList();
      default:
        return friends;
    }
  }
}