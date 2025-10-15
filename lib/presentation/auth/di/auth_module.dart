import 'package:bearnshare/app/di/base/injectable_module.dart';
import 'package:bearnshare/data/network/auth/auth_api.dart';
import 'package:bearnshare/domain/auth/auth_repository.dart';

class AuthModule extends InjectableModule {
  @override
  Future<void> inject() async {
    safeRegisterSingleton<AuthRepository>(() => AuthApi());
  }

  @override
  void dispose() {
    safeUnregister<AuthRepository>();
  }
}
