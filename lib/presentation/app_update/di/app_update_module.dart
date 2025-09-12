import 'package:ev_flutter_app/app/di/base/injectable_module.dart';
import 'package:ev_flutter_app/data/network/app_update/app_update_repository_impl.dart';
import 'package:ev_flutter_app/domain/app_update/app_update_repository.dart';
import 'package:ev_flutter_app/domain/app_update/use_cases/check_app_update_use_case.dart';
import 'package:ev_flutter_app/domain/app_update/use_cases/perform_force_update_use_case.dart';
import 'package:ev_flutter_app/domain/app_update/use_cases/perform_soft_update_use_case.dart';
import 'package:ev_flutter_app/domain/auth/auth_repository.dart';
import 'package:ev_flutter_app/presentation/app_update/bloc/app_update_bloc.dart';

class AppUpdateModule extends InjectableModule {
  @override
  Future<void> inject() async {
    safeRegisterSingleton<AppUpdateRepository>(() => AppUpdateRepositoryImpl());
    safeRegisterSingleton<CheckAppUpdateUseCase>(() => CheckAppUpdateUseCase());
    safeRegisterSingleton<PerformSoftUpdateUseCase>(
        () => PerformSoftUpdateUseCase());
    safeRegisterSingleton<PerformForceUpdateUseCase>(
        () => PerformForceUpdateUseCase());
    safeRegisterSingleton<AppUpdateBloc>(() => AppUpdateBloc());
  }

  @override
  void dispose() {
    safeUnregister<AuthRepository>();
    safeUnregister<AppUpdateRepositoryImpl>();
    safeUnregister<CheckAppUpdateUseCase>();
    safeUnregister<PerformForceUpdateUseCase>();
    safeUnregister<PerformSoftUpdateUseCase>();
  }
}
