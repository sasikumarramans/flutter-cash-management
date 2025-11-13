import 'package:bearnshare/app/di/base/injectable_module.dart';
import 'package:bearnshare/data/network/activity/activity_api.dart';
import 'package:bearnshare/domain/activity/activity_repository.dart';
import 'package:bearnshare/domain/activity/use_cases/get_activities_use_case.dart';
import 'package:bearnshare/presentation/split_activities/bloc/split_activity_bloc.dart';

class SplitActivityModule extends InjectableModule {
  @override
  Future<void> inject() async {
    safeRegisterSingleton<ActivityRepository>(() => ActivityApi());
    safeRegisterSingleton<GetActivitiesUseCase>(() => GetActivitiesUseCase());
  }

  @override
  void injectBloc() {
    safeRegisterSingleton<SplitActivityBloc>(() => SplitActivityBloc());
  }

  @override
  void dispose() {
    safeUnregister<GetActivitiesUseCase>();
    safeUnregister<ActivityRepository>();
    safeUnregister<SplitActivityBloc>();
  }
}