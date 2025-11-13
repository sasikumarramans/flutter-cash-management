import 'package:bearnshare/app/di/base/injectable_module.dart';
import 'package:bearnshare/data/network/friends/friends_api.dart';
import 'package:bearnshare/domain/friends/friends_repository.dart';
import 'package:bearnshare/domain/friends/use_cases/get_friends_use_case.dart';
import 'package:bearnshare/presentation/split_friends/bloc/split_friends_bloc.dart';

class SplitFriendsModule extends InjectableModule {
  @override
  Future<void> inject() async {
    safeRegisterSingleton<FriendsRepository>(() => FriendsApi());
    safeRegisterSingleton<GetFriendsUseCase>(() => GetFriendsUseCase());
  }

  @override
  void injectBloc() {
    safeRegisterSingleton<SplitFriendsBloc>(() => SplitFriendsBloc());
  }

  @override
  void dispose() {
    safeUnregister<GetFriendsUseCase>();
    safeUnregister<FriendsRepository>();
    safeUnregister<SplitFriendsBloc>();
  }
}