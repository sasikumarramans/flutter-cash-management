import 'package:ev_flutter_app/app/di/base/injectable_module.dart';
import 'package:ev_flutter_app/app/helpers/app_snack_bar_manager.dart';
import 'package:ev_flutter_app/app/helpers/permissions_manager.dart';
import 'package:ev_flutter_app/app/helpers/url_manager.dart';
import 'package:ev_flutter_app/app/router/router_manager.dart';
import 'package:ev_flutter_app/fcm_service.dart';
import 'package:ev_flutter_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../presentation/notification/notification_manager.dart';

class AppModule {
  // todo: dispose all singletons

  Future<void> init({List<InjectableModule>? modules}) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    GetIt.I.registerSingleton<RouterManager>(RouterManager());
    GetIt.I.registerSingleton<AppSnackBarManager>(AppSnackBarManager());
    GetIt.I.registerSingleton<UrlManager>(UrlManager());
    GetIt.I.registerSingleton<PermissionsManager>(PermissionsManager());

    if (kDebugMode) {
      Logger.level = Level.all;
    } else {
      Logger.level = Level.off;
    }

    FlutterError.onError = (details) {
      Logger().e(
        details.exceptionAsString(),
        error: details.exception,
        stackTrace: details.stack,
      );
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    // Inject dependencies for provided modules
    await Future.forEach<InjectableModule>(
      modules ?? [],
      (module) async {
        await module.inject();
        module.injectBloc();
      },
    );

    GetIt.I.registerSingleton<FCMService>(FCMService());
  }

  Future<void> lateInit({List<InjectableModule>? modules}) async {
    Future.forEach<InjectableModule>(
      modules ?? [],
      (module) async {
        module.lateInject();
      },
    );

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    GetIt.I.registerSingleton<NotificationManager>(
      NotificationManager(
          flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin),
    );
  }
}
