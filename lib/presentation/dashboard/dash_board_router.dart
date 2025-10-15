import 'package:ev_flutter_app/app/router/animation/fade_transition_screen.dart';
import 'package:ev_flutter_app/app/router/router_manager.dart';
import 'package:ev_flutter_app/app/router/router_scope.dart';
import 'package:ev_flutter_app/presentation/auth/home/home_screen.dart';
import 'package:ev_flutter_app/presentation/history/history_screen.dart';
import 'package:ev_flutter_app/presentation/ledger_book/ledger_book_screen.dart';
import 'package:ev_flutter_app/presentation/profile/profile_screen.dart';
import 'package:flutter/material.dart';
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
                  child: const HomeScreen(),
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
                  child: const LedgerBookScreen(),
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
              return FadeTransitionScreen<void>(
                child: RouterScope(
                  key: historyScreenKey,
                  inject: () {},
                  dispose: () {},
                  child: const HistoryScreen(),
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
              return FadeTransitionScreen<void>(
                child: RouterScope(
                  key: profileScreenKey,
                  inject: () {},
                  dispose: () {},
                  child: const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
    ];
  }
}
