import 'dart:async';

import 'package:bearnshare/app/bloc/base/base_bloc.dart';
import 'package:bearnshare/app/environment.dart';
import 'package:bearnshare/app/helpers/app_snack_bar_manager.dart';
import 'package:bearnshare/app/helpers/download_manager.dart';
import 'package:bearnshare/app/helpers/share_manager.dart';
import 'package:bearnshare/domain/reports/model/get_report_download_request.dart';
import 'package:bearnshare/domain/reports/model/get_report_summary_request.dart';
import 'package:bearnshare/domain/reports/model/get_report_summary_response.dart';
import 'package:bearnshare/domain/reports/use_cases/get_report_download_use_case.dart';
import 'package:bearnshare/domain/reports/use_cases/get_report_summary_use_case.dart';
import 'package:bearnshare/presentation/reports/bloc/reports_event.dart';
import 'package:bearnshare/presentation/reports/bloc/reports_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class ReportsBloc extends BaseBloc<ReportsEvent, ReportsState> {
  late final _getReportSummaryUseCase = GetIt.I.get<GetReportSummaryUseCase>();
  late final _getReportDownloadUseCase =
      GetIt.I.get<GetReportDownloadUseCase>();
  static const int _pageSize = 10;
  late final _downloadManager = GetIt.I<DownloadManager>();
  late final _shareManager = GetIt.I<ShareManager>();

  ReportsBloc() : super(const ReportsState()) {
    on<LoadReportSummary>(_onLoadReportSummary);
    on<LoadMoreCategories>(_onLoadMoreCategories);
    on<ChangePeriodFilter>(_onChangePeriodFilter);
    on<GetReportDownload>(_downloadPdfFileAndThen);
  }

  Future<void> _downloadPdfFileAndThen(
    GetReportDownload event,
    Emitter<ReportsState> emit,
  ) async {
    if (state.downloadShareStatus == DownloadShareStatus.downloading) return;
    GetIt.I<AppSnackBarManager>().showLoading();
    emit(state.copyWith(downloadShareStatus: DownloadShareStatus.downloading));

    try {
      final resp = await _getReportDownloadUseCase.execute(
        request: GetReportDownloadRequest(
          period: state.selectedPeriod,
        ),
      );

      final url = resp.downloadUrl;
      if (url.isEmpty) {
        throw Exception("Failed to get PDF report URL");
      }

      final filePath = await _downloadManager.downloadFile(
          "${EnvironmentConfig.apiUrl}api/$url", FileType.pdf);

      emit(state.copyWith(downloadShareStatus: DownloadShareStatus.downloaded));
      await _shareManager.shareFile(filePath, fileType: FileType.pdf);
      await _downloadManager.deleteFile(filePath);
      GetIt.I<AppSnackBarManager>().hideLoading();
    } catch (e) {
      GetIt.I<AppSnackBarManager>().hideLoading();
      debugPrint("Failed to download/handle PDF report: $e");
      emit(state.copyWith(downloadShareStatus: DownloadShareStatus.failed));
    }
    emit(state.copyWith(downloadShareStatus: DownloadShareStatus.initial));
  }

  Future<void> _onLoadReportSummary(
    LoadReportSummary event,
    Emitter<ReportsState> emit,
  ) async {
    try {
      if (!event.isRefresh) {
        emit(state.copyWith(
          status: ReportsStatus.loading,
        ));
      }

      final request = GetReportSummaryRequest(
        period: event.period,
        page: 0,
        size: 10,
      );

      final response = await safeExecute<ReportSummaryData>(
        function: () async {
          return await _getReportSummaryUseCase.execute(
            request: request,
          );
        },
        showLoading: false,
        showError: true,
      );

      if (response != null) {
        final allCategories = response.expenseCategories;
        final initialCategories = allCategories.take(_pageSize).toList();

        emit(state.copyWith(
          reportData: response,
          displayedCategories: initialCategories,
          status: ReportsStatus.success,
          selectedPeriod: event.period,
          currentPage: 0,
          hasMore: allCategories.length > _pageSize,
        ));
      } else {
        emit(state.copyWith(
          status: ReportsStatus.failed,
          errorMessage: 'No data available',
          displayedCategories: [],
          hasMore: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: ReportsStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadMoreCategories(
    LoadMoreCategories event,
    Emitter<ReportsState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMore || state.reportData == null) {
      return;
    }

    try {
      emit(state.copyWith(isLoadingMore: true));

      final allCategories = state.reportData!.expenseCategories;
      final nextPage = state.currentPage + 1;
      final startIndex = nextPage * _pageSize;
      final endIndex = (startIndex + _pageSize).clamp(0, allCategories.length);

      if (startIndex < allCategories.length) {
        final moreCategories = allCategories.sublist(startIndex, endIndex);
        final updatedCategories =
            List<CategoryItem>.from(state.displayedCategories)
              ..addAll(moreCategories);

        emit(state.copyWith(
          displayedCategories: updatedCategories,
          currentPage: nextPage,
          hasMore: endIndex < allCategories.length,
          isLoadingMore: false,
        ));
      } else {
        emit(state.copyWith(
          isLoadingMore: false,
          hasMore: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoadingMore: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onChangePeriodFilter(
    ChangePeriodFilter event,
    Emitter<ReportsState> emit,
  ) async {
    emit(state.copyWith(
      selectedPeriod: event.period,
      displayedCategories: [],
      currentPage: 0,
      hasMore: true,
    ));
    add(LoadReportSummary(period: event.period));
  }
}
