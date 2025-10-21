import 'package:bearnshare/app/di/base/injectable_module.dart';
import 'package:bearnshare/data/network/group/group_api.dart';
import 'package:bearnshare/domain/group/group_repository.dart';
import 'package:bearnshare/domain/group/use_cases/create_group_use_case.dart';
import 'package:bearnshare/domain/group/use_cases/search_users_use_case.dart';
import 'package:bearnshare/presentation/split_create_group/bloc/create_group_bloc.dart';

class CreateGroupModule extends InjectableModule {
  @override
  Future<void> inject() async {
    safeRegisterSingleton<GroupRepository>(() => GroupApi());
    safeRegisterSingleton<CreateGroupUseCase>(() => CreateGroupUseCase());
    safeRegisterSingleton<SearchUsersUseCase>(() => SearchUsersUseCase());
  }

  @override
  void injectBloc() {
    safeRegisterSingleton<CreateGroupBloc>(() => CreateGroupBloc());
  }

  @override
  void dispose() {
    safeUnregister<GroupRepository>();
    safeUnregister<CreateGroupUseCase>();
    safeUnregister<SearchUsersUseCase>();
    safeUnregister<CreateGroupBloc>();
  }
}
