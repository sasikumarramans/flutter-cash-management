import 'package:ev_flutter_app/app/di/base/injectable_module.dart';
import 'package:ev_flutter_app/data/network/auth/auth_api.dart';
import 'package:ev_flutter_app/domain/auth/auth_repository.dart';

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
