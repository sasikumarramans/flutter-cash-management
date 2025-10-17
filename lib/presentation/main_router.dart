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
import 'package:bearnshare/presentation/create_profile/language_selection_screen.dart';
import 'package:bearnshare/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:bearnshare/presentation/dashboard/dash_board_router.dart';
import 'package:bearnshare/presentation/dashboard/dash_board_screen.dart';
import 'package:bearnshare/presentation/dashboard/di/dashboard_module.dart';
import 'package:bearnshare/presentation/ledger_book/add_book_screen.dart';
import 'package:bearnshare/presentation/ledger_book/add_income_screen.dart';
import 'package:bearnshare/presentation/profile/edit_profile_screen.dart';
import 'package:bearnshare/presentation/reports/report_screen.dart';
import 'package:bearnshare/presentation/split_add_expense/add_expense_split_screen.dart';
import 'package:bearnshare/presentation/split_dashboard/bloc/split_dashboard_bloc.dart';
import 'package:bearnshare/presentation/split_dashboard/di/split_dashboard_module.dart';
import 'package:bearnshare/presentation/split_dashboard/split_dash_board_router.dart';
import 'package:bearnshare/presentation/split_dashboard/split_dash_board_screen.dart';
import 'package:bearnshare/presentation/split_report/split_report_screen.dart';
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
  static const String editProfileRoute = '/editProfile';
  static const String addIncomeRoute = '/addIncome';
  static const String addExpenseRoute = '/addExpense';
  static const String splitReportSummaryRoute = '/splitReportSummary';
  static const String addBookRoute = '/addBook';
  static const String languageRoute = '/language';

  static bool isDashboardInitialized = false;

  static List<RouteBase> routes() {
    const Key authScreenKey = Key('authScreen');
    const Key dashboardRouteScreenKey = Key('dashboard');
    const Key reportsScreenKey = Key('reports');
    const Key totalSavingKey = Key('totalSavingRoute');
    const Key createProfileKey = Key('createProfile');
    const Key addIncomeKey = Key('addIncome');
    const Key addExpenseKey = Key('addExpense');
    const Key splitReportSummaryKey = Key('splitReportSummary');
    const Key editProfileKey = Key('editProfile');
    const Key addBookKey = Key('addBook');
    const Key languageBookKey = Key('language');

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
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          final dashboardModule = SplitDashboardModule();
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
                BlocProvider<SplitDashboardBloc>.value(
                  value: GetIt.I<SplitDashboardBloc>(),
                ),
              ],
              child: SplitDashBoardScreen(child: child),
            ),
          );
        },
        branches: SplitDashboardRouter.getBranches(),
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
          final isLanguageUpdated = !GetIt.I<HiveManager>()
              .getFromHive<String>(HiveManager.languageUpdatedKey).isNullOrEmpty;
          if (!isUserLoggedIn) {
            return loginScreenRoute;
          } else if (!isLanguageUpdated) {
            return languageRoute;
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
      GoRoute(
        path: editProfileRoute,
        name: editProfileRoute,
        pageBuilder: (context, state) {
          return SlideTransitionScreen<void>(
            child: RouterScope(
              key: editProfileKey,
              inject: () {},
              dispose: () {},
              child: const EditProfileScreen(),
            ),
          );
        },
      ),
      GoRoute(
        path: addIncomeRoute,
        name: addIncomeRoute,
        pageBuilder: (context, state) {
          return SlideTransitionScreen<void>(
            child: RouterScope(
              key: addIncomeKey,
              inject: () {},
              dispose: () {},
              child: const AddIncomeScreen(),
            ),
          );
        },
      ),
      GoRoute(
        path: addExpenseRoute,
        name: addExpenseRoute,
        pageBuilder: (context, state) {
          return SlideTransitionScreen<void>(
            child: RouterScope(
              key: addExpenseKey,
              inject: () {},
              dispose: () {},
              child: const AddExpenseSplitScreen(),
            ),
          );
        },
      ),
      GoRoute(
        path: splitReportSummaryRoute,
        name: splitReportSummaryRoute,
        pageBuilder: (context, state) {
          return SlideTransitionScreen<void>(
            child: RouterScope(
              key: splitReportSummaryKey,
              inject: () {},
              dispose: () {},
              child: const SplitReportScreen(),
            ),
          );
        },
      ),
      GoRoute(
        path: addBookRoute,
        name: addBookRoute,
        pageBuilder: (context, state) {
          return SlideTransitionScreen<void>(
            child: RouterScope(
              key: addBookKey,
              inject: () {},
              dispose: () {},
              child: const AddBookScreen(),
            ),
          );
        },
      ),
      GoRoute(
        path: languageRoute,
        name: languageRoute,
        pageBuilder: (context, state) {
          return SlideTransitionScreen<void>(
            child: RouterScope(
              key: languageBookKey,
              inject: () {},
              dispose: () {},
              child: const LanguageSelectionScreen(),
            ),
          );
        },
      ),
    ];
  }
}
