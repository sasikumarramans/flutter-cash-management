import 'package:ev_flutter_app/presentation/main_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class RouterManager {
  late final GoRouter goRouter;
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static final shellNavigatorKey = GlobalKey<NavigatorState>();
  static final homeBranchNavigatorKey = GlobalKey<NavigatorState>();
  static final notificationsBranchNavigatorKey = GlobalKey<NavigatorState>();
  static final searchBranchNavigatorKey = GlobalKey<NavigatorState>();
  RouterManager() {
    _initRouter();
  }

  _initRouter() {
    goRouter = GoRouter(
      navigatorKey: rootNavigatorKey,
      debugLogDiagnostics: kDebugMode,
      initialLocation: MainRouter.mainScreenRoute,
      // TODO: To build an error route here.
      routes: MainRouter.routes(),
    );
  }

  String get currentRoute {
    final RouteMatch lastMatch =
        goRouter.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : goRouter.routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();

    return location;
  }

  /// Returns a unique scope name for the given userId by checking GetIt.I.hasScope.
  /// The scope name will be of the format '<userId>_<index>', starting from 0.
  String getUniqueScopeName(String userId) {
    int index = 0;
    String candidate;
    do {
      candidate = '${userId}_$index';
      index++;
    } while (GetIt.I.hasScope(candidate));
    return candidate;
  }
}

extension GoRouterEx on GoRouter {
  void popUntilOrPush(String targetPath, {String fallbackRoute = '/profile'}) {
    try {
      if (isRouteInStack(targetPath)) {
        popUntilByPath(targetPath);
      } else {
        popUntilByPath(fallbackRoute);
        pushNamed(targetPath);
      }
    } catch (e) {
      debugPrint('⚠️ GoRouter popUntilOrPush failed: $e');
      try {
        pushNamed(targetPath);
      } catch (pushError) {
        debugPrint('⚠️ GoRouter fallback push also failed: $pushError');
      }
    }
  }

  bool isRouteInStack(String targetPath) {
    try {
      final matches = routerDelegate.currentConfiguration.matches;
      return matches.any((match) {
        final route = match.route;
        final path = route is GoRoute ? route.path : null;
        return path != null && targetPath.contains(path);
      });
    } catch (e) {
      debugPrint('⚠️ GoRouter _isRouteInStack check failed: $e');
      return false;
    }
  }

  void popUntilByPath(String targetPath) {
    try {
      while (canPop()) {
        final route = routerDelegate.currentConfiguration.matches.last.route;
        final path = route is GoRoute ? route.path : null;
        if (path == null || targetPath.contains(path)) break;
        pop();
      }
    } catch (e) {
      debugPrint('⚠️ GoRouter popUntilByPath failed: $e');
    }
  }
}
