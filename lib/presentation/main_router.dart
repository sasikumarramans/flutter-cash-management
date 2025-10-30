import 'package:bearnshare/app/helpers/extensions/string_extensions.dart';
import 'package:bearnshare/app/router/animation/slide_transition_screen.dart';
import 'package:bearnshare/app/router/animation/vertical_page_transition.dart';
import 'package:bearnshare/app/router/router_scope.dart';
import 'package:bearnshare/data/local/hive_manager.dart';
import 'package:bearnshare/domain/ledger/model/get_books_response.dart';
import 'package:bearnshare/domain/ledger/model/get_entries_response.dart';
import 'package:bearnshare/presentation/auth/di/auth_module.dart';
import 'package:bearnshare/presentation/auth/login/bloc/login_bloc.dart';
import 'package:bearnshare/presentation/auth/login/di/login_module.dart';
import 'package:bearnshare/presentation/auth/login/login_screen.dart';
import 'package:bearnshare/presentation/auth/login_router.dart';
import 'package:bearnshare/presentation/create_book/bloc/create_book_bloc.dart';
import 'package:bearnshare/presentation/create_book/di/create_book_module.dart';
import 'package:bearnshare/presentation/create_profile/bloc/profile_bloc.dart';
import 'package:bearnshare/presentation/create_profile/create_profile_screen.dart';
import 'package:bearnshare/presentation/create_profile/di/profile_module.dart';
import 'package:bearnshare/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:bearnshare/presentation/dashboard/dash_board_router.dart';
import 'package:bearnshare/presentation/dashboard/dash_board_screen.dart';
import 'package:bearnshare/presentation/dashboard/di/dashboard_module.dart';
import 'package:bearnshare/presentation/history/bloc/ledger_history_bloc.dart';
import 'package:bearnshare/presentation/history/di/ledger_history_module.dart';
import 'package:bearnshare/presentation/ledger_book/add_book_screen.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_bloc.dart';
import 'package:bearnshare/presentation/ledger_book/di/ledger_book_module.dart';
import 'package:bearnshare/presentation/ledger_entries/add_income_screen.dart';
import 'package:bearnshare/presentation/ledger_entries/bloc/ledger_entries_bloc.dart';
import 'package:bearnshare/presentation/ledger_entries/di/ledger_entries_module.dart';
import 'package:bearnshare/presentation/profile/edit_profile_screen.dart';
import 'package:bearnshare/presentation/reports/bloc/reports_bloc.dart';
import 'package:bearnshare/presentation/reports/di/reports_module.dart';
import 'package:bearnshare/presentation/reports/report_screen.dart';
import 'package:bearnshare/presentation/split_add/add_expense_split_screen.dart';
import 'package:bearnshare/presentation/split_add/bloc/add_expense_split_bloc.dart';
import 'package:bearnshare/presentation/split_add/di/add_split_module.dart';
import 'package:bearnshare/presentation/split_create_group/bloc/create_group_bloc.dart';
import 'package:bearnshare/presentation/split_create_group/di/create_group_module.dart';
import 'package:bearnshare/presentation/split_create_group/split_create_group_screen.dart';
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
  static const String splitCreateGroupRoute = '/splitCreateGroup';

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
    const Key splitCreateGroupKey = Key('splitCreateGroup');

    return [
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          final dashboardModule = DashboardModule();
          dashboardModule.injectBloc();
          final ledgerBookModule = LedgerBookModule();
          final createBookModule = CreateBookModule();
          ledgerBookModule.injectBloc();
          createBookModule.injectBloc();
          final profileModule = ProfileModule();
          profileModule.injectBloc();
          return RouterScope(
            key: dashboardRouteScreenKey,
            inject: () {
              dashboardModule.inject();
              ledgerBookModule.inject();
              createBookModule.inject();
              profileModule.inject();
            },
            dispose: () {
              dashboardModule.dispose();
              ledgerBookModule.dispose();
              createBookModule.dispose();
            },
            child: MultiBlocProvider(
              providers: [
                BlocProvider<DashboardBloc>.value(
                  value: GetIt.I<DashboardBloc>(),
                ),
                BlocProvider<ProfileBloc>.value(
                  value: GetIt.I<ProfileBloc>(),
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
          final profileModule = ProfileModule();
          profileModule.injectBloc();
          return RouterScope(
            key: dashboardRouteScreenKey,
            inject: () {
              dashboardModule.inject();
              profileModule.inject();
            },
            dispose: () {
              dashboardModule.dispose();
              profileModule.dispose();
            },
            child: MultiBlocProvider(
              providers: [
                BlocProvider<SplitDashboardBloc>.value(
                  value: GetIt.I<SplitDashboardBloc>(),
                ),
                BlocProvider<ProfileBloc>.value(
                  value: GetIt.I<ProfileBloc>(),
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
          if (!isUserLoggedIn) {
            return loginScreenRoute;
          } else if (!isProfileUpdated) {
            return createProfileRoute;
          }

          return SplitDashboardRouter.splitHomeRoute;
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
          final reportsModule = ReportsModule();
          reportsModule.injectBloc();
          return SlideTransitionScreen<void>(
            child: RouterScope(
              key: reportsScreenKey,
              inject: () {
                reportsModule.inject();
              },
              dispose: () {
                reportsModule.dispose();
              },
              child: BlocProvider<ReportsBloc>.value(
                value: GetIt.I<ReportsBloc>(),
                child: const ReportsScreen(),
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: totalSavingRoute,
        name: totalSavingRoute,
        pageBuilder: (context, state) {
          final ledgerHistoryModule = LedgerHistoryModule();
          ledgerHistoryModule.injectBloc();
          return SlideTransitionScreen<void>(
            child: RouterScope(
              key: totalSavingKey,
              inject: () {
                ledgerHistoryModule.inject();
              },
              dispose: () {
                ledgerHistoryModule.dispose();
              },
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<LedgerHistoryBloc>.value(
                    value: GetIt.I<LedgerHistoryBloc>(),
                  ),
                  BlocProvider<LedgerBookBloc>.value(
                    value: GetIt.I<LedgerBookBloc>(),
                  ),
                ],
                child: const TotalSavingsScreen(),
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: createProfileRoute,
        name: createProfileRoute,
        pageBuilder: (context, state) {
          final profileModule = ProfileModule();
          profileModule.injectBloc();
          return SlideTransitionScreen<void>(
            child: RouterScope(
              key: createProfileKey,
              inject: () {
                profileModule.inject();
              },
              dispose: () {},
              child: BlocProvider<ProfileBloc>.value(
                value: GetIt.I<ProfileBloc>(),
                child: const CreateProfileScreen(),
              ),
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
              child: BlocProvider<ProfileBloc>.value(
                value: GetIt.I<ProfileBloc>(),
                child: const EditProfileScreen(),
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: addIncomeRoute,
        name: addIncomeRoute,
        pageBuilder: (context, state) {
          final ledgerEntriesModule = LedgerEntriesModule();
          final data = state.extra as Map<String, dynamic>;
          int bookId = data["bookId"];
          String entryType = data["entryType"];
          int? entryId = data["entryId"];
          EntryItem? entryItem = data["entryItem"];
          ledgerEntriesModule.injectBloc();
          return SlideTransitionScreen<void>(
            child: RouterScope(
              key: addIncomeKey,
              inject: () {
                ledgerEntriesModule.inject();
              },
              dispose: () {
                ledgerEntriesModule.dispose();
              },
              child: BlocProvider<LedgerEntriesBloc>.value(
                value: GetIt.I<LedgerEntriesBloc>(),
                child: AddIncomeScreen(
                  bookId: bookId,
                  entryId: entryId,
                  entryType: entryType,
                  entryItem: entryItem,
                ),
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: addExpenseRoute,
        name: addExpenseRoute,
        pageBuilder: (context, state) {
          final addSplitModule = AddSplitModule();
          addSplitModule.injectBloc();
          return SlideTransitionScreen<void>(
            child: RouterScope(
              key: addExpenseKey,
              inject: () {
                addSplitModule.inject();
              },
              dispose: () {
                addSplitModule.dispose();
              },
              child: BlocProvider<AddExpenseSplitBloc>.value(
                value: GetIt.I<AddExpenseSplitBloc>(),
                child: const AddExpenseSplitScreen(
                  groupId: 0,
                ),
              ),
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
          BooksItem? bookItem;
          if (state.extra != null) {
            final data = state.extra as Map<String, dynamic>;
            bookItem = data["bookItem"];
          }

          return SlideTransitionScreen<void>(
            child: RouterScope(
              key: addBookKey,
              inject: () {},
              dispose: () {},
              child: BlocProvider<CreateBookBloc>.value(
                value: GetIt.I<CreateBookBloc>(),
                child: AddBookScreen(bookItem: bookItem),
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: splitCreateGroupRoute,
        name: splitCreateGroupRoute,
        pageBuilder: (context, state) {
          final createGroupModule = CreateGroupModule();
          createGroupModule.injectBloc();
          return SlideTransitionScreen<void>(
            child: RouterScope(
              key: splitCreateGroupKey,
              inject: () {
                createGroupModule.inject();
              },
              dispose: () {
                createGroupModule.dispose();
              },
              child: BlocProvider<CreateGroupBloc>.value(
                value: GetIt.I<CreateGroupBloc>(),
                child: const SplitCreateGroupScreen(),
              ),
            ),
          );
        },
      ),
    ];
  }
}
