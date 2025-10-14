import 'package:ev_flutter_app/app/di/base/injectable_module.dart';
import 'package:ev_flutter_app/presentation/dashboard/bloc/dashboard_bloc.dart';

class DashboardModule extends InjectableModule {
  @override
  Future<void> inject() async {}

  @override
  void injectBloc() {
    safeRegisterSingleton<DashboardBloc>(() => DashboardBloc());
  }

  @override
  void dispose() {
    safeUnregister<DashboardBloc>();
  }
}
