import 'package:bearnshare/app/bloc/base/base_bloc.dart';
import 'package:bearnshare/domain/activity/model/get_activities_request.dart';
import 'package:bearnshare/domain/activity/model/get_activities_response.dart';
import 'package:bearnshare/domain/activity/use_cases/get_activities_use_case.dart';
import 'package:bearnshare/presentation/split_activities/bloc/split_activity_event.dart';
import 'package:bearnshare/presentation/split_activities/bloc/split_activity_state.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

class SplitActivityBloc extends BaseBloc<SplitActivityEvent, SplitActivityState> {
  late final _getActivitiesUseCase = GetIt.I.get<GetActivitiesUseCase>();

  SplitActivityBloc() : super(const SplitActivityState()) {
    on<LoadActivities>(_onLoadActivities);
    on<LoadMoreActivities>(_onLoadMoreActivities);
    on<FilterActivitiesChanged>(_onFilterActivitiesChanged);
  }

  Future<void> _onLoadActivities(
    LoadActivities event,
    Emitter<SplitActivityState> emit,
  ) async {
    try {
      if (event.isRefresh) {
        emit(state.copyWith(currentPage: 0, hasMore: true));
      } else {
        emit(state.copyWith(status: SplitActivityStatus.loading));
      }

      final request = GetActivitiesRequest(
        type: state.activityType,
        page: 0,
        size: 20,
        sortBy: 'createdAt',
        sortDir: 'desc',
      );

      final response = await safeExecute<ActivitiesResponse>(
        function: () async {
          return await _getActivitiesUseCase.execute(request: request);
        },
        showLoading: false,
        showError: true,
      );

      if (response != null && response.data.content.isNotEmpty) {
        final data = response.data.content;
        final filteredData = _applyFilter(data, state.selectedFilterIndex);

        emit(state.copyWith(
          activities: data,
          filteredActivities: filteredData,
          status: SplitActivityStatus.success,
          hasMore: data.length == 20,
          currentPage: 0,
          totalPages: response.data.totalPages,
        ));
      } else {
        emit(state.copyWith(
          status: SplitActivityStatus.success,
          activities: [],
          filteredActivities: [],
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: SplitActivityStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadMoreActivities(
    LoadMoreActivities event,
    Emitter<SplitActivityState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMore) return;

    try {
      emit(state.copyWith(isLoadingMore: true));

      final nextPage = state.currentPage + 1;
      final request = GetActivitiesRequest(
        type: state.activityType,
        page: nextPage,
        size: 20,
        sortBy: 'createdAt',
        sortDir: 'desc',
      );

      final response = await safeExecute<ActivitiesResponse>(
        function: () async {
          return await _getActivitiesUseCase.execute(request: request);
        },
        showLoading: false,
        showError: true,
      );

      if (response != null && response.data.content.isNotEmpty) {
        final data = response.data.content;
        final updatedActivities = List<ActivityItem>.from(state.activities)
          ..addAll(data);
        final filteredData = _applyFilter(updatedActivities, state.selectedFilterIndex);

        emit(state.copyWith(
          activities: updatedActivities,
          filteredActivities: filteredData,
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

  void _onFilterActivitiesChanged(
    FilterActivitiesChanged event,
    Emitter<SplitActivityState> emit,
  ) {
    String activityType;
    switch (event.filterIndex) {
      case 0:
        activityType = 'all';
        break;
      case 1:
        activityType = 'paid';
        break;
      case 2:
        activityType = 'to_pay';
        break;
      default:
        activityType = 'all';
    }

    emit(state.copyWith(
      selectedFilterIndex: event.filterIndex,
      activityType: activityType,
    ));
    add(const LoadActivities());
  }

  List<ActivityItem> _applyFilter(List<ActivityItem> activities, int filterIndex) {
    switch (filterIndex) {
      case 0: // All
        return activities;
      case 1: // Paid
        return activities.where((activity) {
          return activity.activityType.toLowerCase().contains('paid') ||
                 activity.activityType.toLowerCase().contains('settled');
        }).toList();
      case 2: // To Pay
        return activities.where((activity) {
          return activity.activityType.toLowerCase().contains('expense') ||
                 activity.activityType.toLowerCase().contains('added');
        }).toList();
      default:
        return activities;
    }
  }
}