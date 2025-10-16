import 'package:bearnshare/app/helpers/extensions/string_extensions.dart';
import 'package:bearnshare/app/router/animation/slide_transition_screen.dart';
import 'package:bearnshare/app/router/animation/vertical_page_transition.dart';
import 'package:bearnshare/app/router/router_scope.dart';
import 'package:bearnshare/data/local/hive_manager.dart';
import 'package:bearnshare/presentation/auth/di/auth_module.dart';
import 'package:bearnshare/presentation/auth/login/bloc/login_bloc.dart';
import 'package:bearnshare/presentation/auth/login/di/login_module.dart';
import 'package:bearnshare/presentation/auth/login/login_screen.dart';
import 'package:bearnshare/presentation/auth/login_router.dart';
import 'package:bearnshare/presentation/create_profile/create_profile_screen.dart';
import 'package:bearnshare/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:bearnshare/presentation/dashboard/dash_board_router.dart';
import 'package:bearnshare/presentation/dashboard/dash_board_screen.dart';
import 'package:bearnshare/presentation/dashboard/di/dashboard_module.dart';
import 'package:bearnshare/presentation/reports/report_screen.dart';
import 'package:bearnshare/presentation/total_savings/total_savings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class MainRouter {
  static const String mainScreenRoute = '/';
  static const String homeRoute = '/home';
  static const String loginScreenRoute = '/login';
  static const String reportRoute = '/reports';
  static const String totalSavingRoute = '/totalSaving';
  static const String createProfileRoute = '/createProfile';

  static bool isDashboardInitialized = false;

  static List<RouteBase> routes() {
    const Key authScreenKey = Key('authScreen');
    const Key dashboardRouteScreenKey = Key('dashboard');
    const Key reportsScreenKey = Key('reports');
    const Key totalSavingKey = Key('totalSavingRoute');
    const Key createProfileKey = Key('createProfile');

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
          final isProfileUpdated = GetIt.I<HiveManager>()
                  .getFromHive(HiveManager.profileUpdatedKey) ??
              false;
          if (!isUserLoggedIn) {
            return loginScreenRoute;
          } else if (!isProfileUpdated) {
            return createProfileRoute;
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
      GoRoute(
        path: reportRoute,
        name: reportRoute,
        pageBuilder: (context, state) {
          return SlideTransitionScreen<void>(
            child: RouterScope(
              key: reportsScreenKey,
              inject: () {},
              dispose: () {},
              child: const ReportsScreen(),
            ),
          );
        },
      ),
      GoRoute(
        path: totalSavingRoute,
        name: totalSavingRoute,
        pageBuilder: (context, state) {
          return SlideTransitionScreen<void>(
            child: RouterScope(
              key: totalSavingKey,
              inject: () {},
              dispose: () {},
              child: const TotalSavingsScreen(),
            ),
          );
        },
      ),
      GoRoute(
        path: createProfileRoute,
        name: createProfileRoute,
        pageBuilder: (context, state) {
          return SlideTransitionScreen<void>(
            child: RouterScope(
              key: createProfileKey,
              inject: () {},
              dispose: () {},
              child: const CreateProfileScreen(),
            ),
          );
        },
      ),
    ];
  }
}
