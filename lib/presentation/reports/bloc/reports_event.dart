import 'package:equatable/equatable.dart';

sealed class ReportsEvent extends Equatable {
  const ReportsEvent();

  @override
  List<Object?> get props => [];
}

class LoadReportSummary extends ReportsEvent {
  final String period;
  final bool isRefresh;

  const LoadReportSummary({
    required this.period,
    this.isRefresh = false,
  });
}

class LoadMoreCategories extends ReportsEvent {
  const LoadMoreCategories();
}

class ChangePeriodFilter extends ReportsEvent {
  final String period;

  const ChangePeriodFilter(this.period);
}

class GetReportDownload extends ReportsEvent {
  const GetReportDownload();
}
