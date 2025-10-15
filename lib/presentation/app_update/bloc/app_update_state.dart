import 'package:equatable/equatable.dart';
import 'package:bearnshare/domain/app_update/model/app_update_info.dart';

enum AppUpdateStatus {
  initial,
  loading,
  available,
  required,
  notAvailable,
  inProgress,
  error
}

class AppUpdateState extends Equatable {
  final AppUpdateStatus status;
  final AppUpdateModel? updateInfo;
  final String? errorMessage;

  const AppUpdateState({
    this.status = AppUpdateStatus.initial,
    this.updateInfo,
    this.errorMessage,
  });

  AppUpdateState copyWith({
    AppUpdateStatus? status,
    AppUpdateModel? updateInfo,
    String? errorMessage,
  }) {
    return AppUpdateState(
      status: status ?? this.status,
      updateInfo: updateInfo ?? this.updateInfo,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, updateInfo, errorMessage];
}
