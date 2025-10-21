import 'package:bearnshare/app/di/base/injectable_module.dart';
import 'package:bearnshare/data/network/group/group_api.dart';
import 'package:bearnshare/domain/group/group_repository.dart';
import 'package:bearnshare/domain/group/use_cases/get_groups_use_case.dart';
import 'package:bearnshare/presentation/split_group/bloc/split_group_bloc.dart';

class SplitGroupModule extends InjectableModule {
  @override
  Future<void> inject() async {
    safeRegisterSingleton<GroupRepository>(() => GroupApi());
    safeRegisterSingleton<GetGroupsUseCase>(() => GetGroupsUseCase());
  }

  @override
  void injectBloc() {
    safeRegisterSingleton<SplitGroupBloc>(() => SplitGroupBloc());
  }

  @override
  void dispose() {
    safeUnregister<GetGroupsUseCase>();
    safeUnregister<GroupRepository>();
    safeUnregister<SplitGroupBloc>();
  }
}
