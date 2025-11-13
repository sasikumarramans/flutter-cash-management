import 'package:bearnshare/app/router/animation/fade_transition_screen.dart';
import 'package:bearnshare/app/router/router_manager.dart';
import 'package:bearnshare/app/router/router_scope.dart';
import 'package:bearnshare/presentation/create_profile/bloc/profile_bloc.dart';
import 'package:bearnshare/presentation/profile/profile_screen.dart';
import 'package:bearnshare/presentation/split_activities/bloc/split_activity_bloc.dart';
import 'package:bearnshare/presentation/split_activities/di/split_activity_module.dart';
import 'package:bearnshare/presentation/split_activities/split_activity_screen.dart';
import 'package:bearnshare/presentation/split_friends/bloc/split_friends_bloc.dart';
import 'package:bearnshare/presentation/split_friends/di/split_friends_module.dart';
import 'package:bearnshare/presentation/split_friends/split_friends_screen.dart';
import 'package:bearnshare/presentation/split_group/bloc/split_group_bloc.dart';
import 'package:bearnshare/presentation/split_group/split_group_screen.dart';
import 'package:bearnshare/presentation/split_home/split_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class SplitDashboardRouter {
  static const String splitHomeRoute = '/splitHome';
  static const String splitGroupRoute = '/splitGroup';
  static const String friendsRoute = '/splitFriends';
  static const String splitActivityRoute = '/splitActivity';
  static const String splitProfileRoute = '/splitProfile';
  static List<StatefulShellBranch> getBranches() {
    const Key splitHomeScreenKey = Key('splitHomeScreen');
    const Key groupScreenKey = Key('groupScreen');
    const Key friendsScreenKey = Key('friendsScreen');
    const Key splitProfileScreenKey = Key('splitProfileScreen');
    const Key splitActivityKey = Key('splitActivity');
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
        navigatorKey: RouterManager.groupNavigatorKey,
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
                  child: BlocProvider<SplitGroupBloc>.value(
                    value: GetIt.I<SplitGroupBloc>(),
                    child: const SplitGroupScreen(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: RouterManager.friendsKey,
        routes: [
          GoRoute(
            path: friendsRoute,
            name: friendsRoute,
            pageBuilder: (context, state) {
              final module = SplitFriendsModule();
              module.injectBloc();
              return FadeTransitionScreen<void>(
                child: RouterScope(
                  key: friendsScreenKey,
                  inject: () {
                    module.inject();
                  },
                  dispose: () {
                    module.dispose();
                  },
                  child: BlocProvider<SplitFriendsBloc>.value(
                    value: GetIt.I<SplitFriendsBloc>(),
                    child: const SplitFriendsScreen(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: RouterManager.activityKey,
        routes: [
          GoRoute(
            path: splitActivityRoute,
            name: splitActivityRoute,
            pageBuilder: (context, state) {
              final module = SplitActivityModule();
              module.injectBloc();
              return FadeTransitionScreen<void>(
                child: RouterScope(
                  key: splitActivityKey,
                  inject: () {
                    module.inject();
                  },
                  dispose: () {
                    module.dispose();
                  },
                  child: BlocProvider<SplitActivityBloc>.value(
                    value: GetIt.I<SplitActivityBloc>(),
                    child: const SplitActivityScreen(),
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
            path: splitProfileRoute,
            name: splitProfileRoute,
            pageBuilder: (context, state) {
              return FadeTransitionScreen<void>(
                child: RouterScope(
                  key: splitProfileScreenKey,
                  inject: () {},
                  dispose: () {},
                  child: BlocProvider<ProfileBloc>.value(
                    value: GetIt.I<ProfileBloc>(),
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
