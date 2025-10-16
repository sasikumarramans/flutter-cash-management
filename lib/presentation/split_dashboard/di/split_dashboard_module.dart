import 'package:bearnshare/app/di/base/injectable_module.dart';
import 'package:bearnshare/presentation/split_dashboard/bloc/split_dashboard_bloc.dart';

class SplitDashboardModule extends InjectableModule {
  @override
  Future<void> inject() async {}

  @override
  void injectBloc() {
    safeRegisterSingleton<SplitDashboardBloc>(() => SplitDashboardBloc());
  }

  @override
  void dispose() {
    safeUnregister<SplitDashboardBloc>();
  }
}
