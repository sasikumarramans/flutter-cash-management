import 'package:bearnshare/app/router/animation/fade_transition_screen.dart';
import 'package:bearnshare/app/router/router_manager.dart';
import 'package:bearnshare/app/router/router_scope.dart';
import 'package:bearnshare/presentation/profile/profile_screen.dart';
import 'package:bearnshare/presentation/split_friends/split_friends_screen.dart';
import 'package:bearnshare/presentation/split_group/split_group_screen.dart';
import 'package:bearnshare/presentation/split_home/split_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplitDashboardRouter {
  static const String splitHomeRoute = '/splitHome';
  static const String splitGroupRoute = '/splitGroup';
  static const String friendsRoute = '/splitFriends';
  static const String splitProfileRoute = '/splitProfile';
  static List<StatefulShellBranch> getBranches() {
    const Key splitHomeScreenKey = Key('splitHomeScreen');
    const Key groupScreenKey = Key('groupScreen');
    const Key friendsScreenKey = Key('friendsScreen');
    const Key splitProfileScreenKey = Key('splitProfileScreen');
    return [
      StatefulShellBranch(
        navigatorKey: RouterManager.splitHomeBranchNavigatorKey,
        routes: [
          GoRoute(
            path: splitHomeRoute,
            name: splitHomeRoute,
            pageBuilder: (context, state) {
              return FadeTransitionScreen<void>(
                child: RouterScope(
                  key: splitHomeScreenKey,
                  inject: () {},
                  dispose: () {},
                  child: const SplitHomeScreen(),
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
            path: splitGroupRoute,
            name: splitGroupRoute,
            pageBuilder: (context, state) {
              return FadeTransitionScreen<void>(
                child: RouterScope(
                  key: groupScreenKey,
                  inject: () {},
                  dispose: () {},
                  child: const SplitGroupScreen(),
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
            path: friendsRoute,
            name: friendsRoute,
            pageBuilder: (context, state) {
              return FadeTransitionScreen<void>(
                child: RouterScope(
                  key: friendsScreenKey,
                  inject: () {},
                  dispose: () {},
                  child: const SplitFriendsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: RouterManager.splitProfileNavigatorKey,
        routes: [
          GoRoute(
            path: splitProfileRoute,
            name: splitProfileRoute,
            pageBuilder: (context, state) {
              return FadeTransitionScreen<void>(
                child: RouterScope(
                  key: splitProfileScreenKey,
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
