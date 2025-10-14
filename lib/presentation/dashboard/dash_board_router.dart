import 'package:ev_flutter_app/app/router/animation/fade_transition_screen.dart';
import 'package:ev_flutter_app/app/router/router_manager.dart';
import 'package:ev_flutter_app/app/router/router_scope.dart';
import 'package:ev_flutter_app/presentation/auth/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardRouter {
  static const String homeRoute = '/home';
  static List<StatefulShellBranch> getBranches() {
    const Key homeScreenKey = Key('homeScreen');
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
    ];
  }
}
