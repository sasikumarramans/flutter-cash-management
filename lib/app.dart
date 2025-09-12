import 'package:ev_flutter_app/app/router/router_manager.dart';
import 'package:ev_flutter_app/app/theme/app_theme.dart';
import 'package:ev_flutter_app/data/local/hive_manager.dart';
import 'package:ev_flutter_app/generated/l10n.dart';
import 'package:ev_flutter_app/presentation/app_update/app_update_screen.dart';
import 'package:ev_flutter_app/presentation/app_update/bloc/app_update_bloc.dart';
import 'package:ev_flutter_app/presentation/component/app_progress_indicator.dart';
import 'package:ev_flutter_app/presentation/component/locale/bloc/locale_bloc.dart';
import 'package:ev_flutter_app/presentation/component/locale/bloc/locale_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("app open");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: GetIt.I<LocaleBloc>()),
        BlocProvider.value(value: GetIt.I<AppUpdateBloc>()),
      ],
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return GlobalLoaderOverlay(
            overlayColor: Colors.grey.withValues(alpha: 0.5),
            overlayWidgetBuilder: (_) {
              return const AppProgressIndicator();
            },
            child: Portal(
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                locale: state.locale,
                theme: AppTheme.getTheme(),
                supportedLocales: S.delegate.supportedLocales,
                routerConfig: GetIt.I.get<RouterManager>().goRouter,
                builder: (context, child) {
                  return AppUpdateManager(child: child ?? const SizedBox());
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Future<void> dispose() async {
    if (kDebugMode) {
      print("app close");
    }
    await GetIt.I<HiveManager>().closeHive();
    super.dispose();
  }
}
