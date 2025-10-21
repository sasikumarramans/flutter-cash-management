import 'package:bearnshare/app/di/base/injectable_module.dart';
import 'package:bearnshare/data/network/profile/profile_api.dart';
import 'package:bearnshare/domain/profile/profile_repository.dart';
import 'package:bearnshare/domain/profile/use_cases/get_profile_use_case.dart';
import 'package:bearnshare/domain/profile/use_cases/unique_username_use_case.dart';
import 'package:bearnshare/domain/profile/use_cases/update_profile_use_case.dart';
import 'package:bearnshare/presentation/create_profile/bloc/profile_bloc.dart';

class ProfileModule extends InjectableModule {
  @override
  Future<void> inject() async {
    safeRegisterSingleton<ProfileRepository>(() => ProfileApi());
    safeRegisterSingleton<UniqueUsernameUseCase>(() => UniqueUsernameUseCase());
    safeRegisterSingleton<UpdateProfileUseCase>(() => UpdateProfileUseCase());
    safeRegisterSingleton<GetProfileUseCase>(() => GetProfileUseCase());
  }

  @override
  void injectBloc() {
    safeRegisterSingleton<ProfileBloc>(() => ProfileBloc());
  }

  @override
  void dispose() {
    safeUnregister<ProfileRepository>();
    safeUnregister<UniqueUsernameUseCase>();
    safeUnregister<UpdateProfileUseCase>();
    safeUnregister<ProfileBloc>();
    safeUnregister<GetProfileUseCase>();
  }
}
