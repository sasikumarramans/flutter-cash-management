import 'package:bearnshare/domain/activity/model/get_activities_response.dart';
import 'package:equatable/equatable.dart';

enum SplitActivityStatus {
  initial,
  loading,
  success,
  failed,
}

class SplitActivityState extends Equatable {
  final List<ActivityItem> activities;
  final List<ActivityItem> filteredActivities;
  final SplitActivityStatus status;
  final String? errorMessage;
  final int currentPage;
  final int totalPages;
  final bool hasMore;
  final bool isLoadingMore;
  final int selectedFilterIndex;
  final String activityType;

  const SplitActivityState({
    this.activities = const [],
    this.filteredActivities = const [],
    this.status = SplitActivityStatus.initial,
    this.errorMessage,
    this.currentPage = 0,
    this.totalPages = 0,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.selectedFilterIndex = 0,
    this.activityType = 'all',
  });

  SplitActivityState copyWith({
    List<ActivityItem>? activities,
    List<ActivityItem>? filteredActivities,
    SplitActivityStatus? status,
    String? errorMessage,
    int? currentPage,
    int? totalPages,
    bool? hasMore,
    bool? isLoadingMore,
    int? selectedFilterIndex,
    String? activityType,
  }) {
    return SplitActivityState(
      activities: activities ?? this.activities,
      filteredActivities: filteredActivities ?? this.filteredActivities,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      selectedFilterIndex: selectedFilterIndex ?? this.selectedFilterIndex,
      activityType: activityType ?? this.activityType,
    );
  }

  @override
  List<Object?> get props => [
        activities,
        filteredActivities,
        status,
        errorMessage,
        currentPage,
        totalPages,
        hasMore,
        isLoadingMore,
        selectedFilterIndex,
        activityType,
      ];
}