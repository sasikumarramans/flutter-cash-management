import 'package:bearnshare/app/helpers/extensions/string_extensions.dart';
import 'package:bearnshare/app/router/animation/vertical_page_transition.dart';
import 'package:bearnshare/app/router/router_scope.dart';
import 'package:bearnshare/data/local/hive_manager.dart';
import 'package:bearnshare/presentation/auth/di/auth_module.dart';
import 'package:bearnshare/presentation/auth/login/bloc/login_bloc.dart';
import 'package:bearnshare/presentation/auth/login/di/login_module.dart';
import 'package:bearnshare/presentation/auth/login/login_screen.dart';
import 'package:bearnshare/presentation/auth/login_router.dart';
import 'package:bearnshare/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:bearnshare/presentation/dashboard/dash_board_router.dart';
import 'package:bearnshare/presentation/dashboard/dash_board_screen.dart';
import 'package:bearnshare/presentation/dashboard/di/dashboard_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class MainRouter {
  static const String mainScreenRoute = '/';
  static const String homeRoute = '/home';
  static const String loginScreenRoute = '/login';

  static bool isDashboardInitialized = false;

  static List<RouteBase> routes() {
    const Key authScreenKey = Key('authScreen');
    const Key dashboardRouteScreenKey = Key('dashboard');

    return [
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          final dashboardModule = DashboardModule();
          dashboardModule.injectBloc();
          return RouterScope(
            key: dashboardRouteScreenKey,
            inject: () {
              dashboardModule.inject();
            },
            dispose: () {
              dashboardModule.dispose();
            },
            child: MultiBlocProvider(
              providers: [
                BlocProvider<DashboardBloc>.value(
                  value: GetIt.I<DashboardBloc>(),
                ),
              ],
              child: DashboardScreen(child: child),
            ),
          );
        },
        branches: DashboardRouter.getBranches(),
      ),
      GoRoute(
        path: mainScreenRoute,
        redirect: (context, state) async {
          final isUserLoggedIn = !GetIt.I<HiveManager>()
              .getFromHive<String>(HiveManager.userSessionTokenKey)
              .isNullOrEmpty;
          if (!isUserLoggedIn) {
            return loginScreenRoute;
          }

          return homeRoute;
        },
      ),
      GoRoute(
        path: loginScreenRoute,
        name: loginScreenRoute,
        pageBuilder: (context, state) {
          final authModule = AuthModule();
          final loginModule = LoginModule();

          loginModule.injectBloc();
          return VerticalSlideTransitionScreen<void>(
            isGoingDown: true,
            child: RouterScope(
              key: authScreenKey,
              inject: () {
                authModule.inject();
                loginModule.inject();
              },
              dispose: () {
                authModule.dispose();
                loginModule.dispose();
              },
              child: BlocProvider<LoginBloc>.value(
                value: GetIt.I<LoginBloc>(),
                child: const LoginScreen(),
              ),
            ),
          );
        },
        routes: LoginRouter.routes(),
      ),
    ];
  }
}
