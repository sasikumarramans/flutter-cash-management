import 'package:bearnshare/domain/reports/model/get_report_summary_response.dart';
import 'package:equatable/equatable.dart';

enum ReportsStatus {
  initial,
  loading,
  success,
  failed,
}

enum DownloadShareStatus {
  initial,
  downloading,
  downloaded,
  failed,
}

class ReportsState extends Equatable {
  final ReportSummaryData? reportData;
  final List<CategoryItem> displayedCategories;
  final ReportsStatus status;
  final String? errorMessage;
  final String selectedPeriod;
  final int currentPage;
  final bool hasMore;
  final bool isLoadingMore;
  final DownloadShareStatus downloadShareStatus;

  const ReportsState({
    this.reportData,
    this.displayedCategories = const [],
    this.status = ReportsStatus.initial,
    this.errorMessage,
    this.selectedPeriod = 'THIS_MONTH',
    this.currentPage = 0,
    this.downloadShareStatus = DownloadShareStatus.initial,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  ReportsState copyWith({
    ReportSummaryData? reportData,
    List<CategoryItem>? displayedCategories,
    ReportsStatus? status,
    String? errorMessage,
    String? selectedPeriod,
    int? currentPage,
    bool? hasMore,
    bool? isLoadingMore,
    DownloadShareStatus? downloadShareStatus,
  }) {
    return ReportsState(
      reportData: reportData ?? this.reportData,
      displayedCategories: displayedCategories ?? this.displayedCategories,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      downloadShareStatus: downloadShareStatus ?? this.downloadShareStatus,
    );
  }

  @override
  List<Object?> get props => [
        reportData,
        displayedCategories,
        status,
        errorMessage,
        selectedPeriod,
        currentPage,
        hasMore,
        isLoadingMore,
        downloadShareStatus,
      ];
}
