import 'package:bearnshare/app/router/animation/fade_transition_screen.dart';
import 'package:bearnshare/app/router/router_manager.dart';
import 'package:bearnshare/app/router/router_scope.dart';
import 'package:bearnshare/presentation/auth/home/home_screen.dart';
import 'package:bearnshare/presentation/create_profile/bloc/profile_bloc.dart';
import 'package:bearnshare/presentation/create_profile/di/profile_module.dart';
import 'package:bearnshare/presentation/history/bloc/ledger_history_bloc.dart';
import 'package:bearnshare/presentation/history/di/ledger_history_module.dart';
import 'package:bearnshare/presentation/history/history_screen.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_bloc.dart';
import 'package:bearnshare/presentation/ledger_book/ledger_book_screen.dart';
import 'package:bearnshare/presentation/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class DashboardRouter {
  static const String homeRoute = '/home';
  static const String ledgerRoute = '/ledger';
  static const String historyRoute = '/history';
  static const String profileRoute = '/profile';
  static List<StatefulShellBranch> getBranches() {
    const Key homeScreenKey = Key('homeScreen');
    const Key ledgerScreenKey = Key('ledgerScreen');
    const Key historyScreenKey = Key('historyScreen');
    const Key profileScreenKey = Key('profileScreen');
    return [
      StatefulShellBranch(
        navigatorKey: RouterManager.homeBranchNavigatorKey,
        routes: [
          GoRoute(
            path: homeRoute,
            name: homeRoute,
            pageBuilder: (context, state) {
              return FadeTransitionScreen<void>(
                child: RouterScope(
                  key: homeScreenKey,
                  inject: () {},
                  dispose: () {},
                  child: BlocProvider<LedgerBookBloc>.value(
                    value: GetIt.I<LedgerBookBloc>(),
                    child: const HomeScreen(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: RouterManager.ledgerNavigatorKey,
        routes: [
          GoRoute(
            path: ledgerRoute,
            name: ledgerRoute,
            pageBuilder: (context, state) {
              return FadeTransitionScreen<void>(
                child: RouterScope(
                  key: ledgerScreenKey,
                  inject: () {},
                  dispose: () {},
                  child: BlocProvider<LedgerBookBloc>.value(
                    value: GetIt.I<LedgerBookBloc>(),
                    child: const LedgerBookScreen(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: RouterManager.historyKey,
        routes: [
          GoRoute(
            path: historyRoute,
            name: historyRoute,
            pageBuilder: (context, state) {
              final ledgerHistoryModule = LedgerHistoryModule();
              ledgerHistoryModule.injectBloc();
              return FadeTransitionScreen<void>(
                child: RouterScope(
                  key: historyScreenKey,
                  inject: () {
                    ledgerHistoryModule.inject();
                  },
                  dispose: () {
                    ledgerHistoryModule.dispose();
                  },
                  child: BlocProvider<LedgerHistoryBloc>.value(
                    value: GetIt.I<LedgerHistoryBloc>(),
                    child: const HistoryScreen(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: RouterManager.profileNavigatorKey,
        routes: [
          GoRoute(
            path: profileRoute,
            name: profileRoute,
            pageBuilder: (context, state) {
              final profileModule = ProfileModule();
              profileModule.injectBloc();
              return FadeTransitionScreen<void>(
                child: RouterScope(
                  key: profileScreenKey,
                  inject: () {
                    profileModule.inject();
                  },
                  dispose: () {},
                  child: BlocProvider<ProfileBloc>.value(
                    value: GetIt.I.get<ProfileBloc>(),
                    child: const ProfileScreen(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ];
  }
}
