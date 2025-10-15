import 'package:bearnshare/app/di/base/injectable_module.dart';
import 'package:bearnshare/presentation/component/locale/bloc/locale_bloc.dart';

class LocaleModule extends InjectableModule {
  @override
  Future<void> inject() async {
    safeRegisterSingleton<LocaleBloc>(() => LocaleBloc());
  }

  @override
  void dispose() {
    safeUnregister<LocaleBloc>();
  }
}
