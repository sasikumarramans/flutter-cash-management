import 'package:bearnshare/domain/app_update/use_cases/check_app_update_use_case.dart';
import 'package:bearnshare/domain/app_update/use_cases/perform_force_update_use_case.dart';
import 'package:bearnshare/domain/app_update/use_cases/perform_soft_update_use_case.dart';
import 'package:bearnshare/presentation/app_update/bloc/app_update_event.dart';
import 'package:bearnshare/presentation/app_update/bloc/app_update_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AppUpdateBloc extends Bloc<AppUpdateEvent, AppUpdateState> {
  final _checkAppUpdateUseCase = GetIt.I<CheckAppUpdateUseCase>();
  final _performSoftUpdateUseCase = GetIt.I<PerformSoftUpdateUseCase>();
  final _performForceUpdateUseCase = GetIt.I<PerformForceUpdateUseCase>();

  AppUpdateBloc() : super(const AppUpdateState()) {
    on<CheckForUpdate>(_onCheckForUpdate);
    on<PerformUpdate>(_onPerSoftUpdate);
    on<PerForceUpdate>(_onPerForceUpdate);
  }

  Future<void> _onCheckForUpdate(
    CheckForUpdate event,
    Emitter<AppUpdateState> emit,
  ) async {
    emit(state.copyWith(status: AppUpdateStatus.loading));

    try {
      final updateInfo = await _checkAppUpdateUseCase.execute();
      if (updateInfo.isUpdateRequired && updateInfo.isUpdateAvailable) {
        emit(state.copyWith(
          status: AppUpdateStatus.required,
          updateInfo: updateInfo,
        ));
      } else if (updateInfo.isUpdateAvailable) {
        emit(state.copyWith(
          status: AppUpdateStatus.available,
          updateInfo: updateInfo,
        ));
      } else {
        emit(state.copyWith(
          status: AppUpdateStatus.notAvailable,
          updateInfo: updateInfo,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AppUpdateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onPerSoftUpdate(
    PerformUpdate event,
    Emitter<AppUpdateState> emit,
  ) async {
    emit(state.copyWith(status: AppUpdateStatus.inProgress));

    try {
      await _performSoftUpdateUseCase.execute(request: event.context);
    } catch (e) {
      emit(state.copyWith(
        status: AppUpdateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onPerForceUpdate(
    PerForceUpdate event,
    Emitter<AppUpdateState> emit,
  ) async {
    emit(state.copyWith(status: AppUpdateStatus.inProgress));

    try {
      await _performForceUpdateUseCase.execute(request: event.context);
    } catch (e) {
      emit(state.copyWith(
        status: AppUpdateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
