import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/generated/assets.gen.dart';
import 'package:bearnshare/presentation/component/app_bottom_nav_bar.dart';
import 'package:bearnshare/presentation/component/cache_manager/profile_cached_image_shimmer.dart';
import 'package:bearnshare/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:bearnshare/presentation/dashboard/bloc/dashboard_event.dart';
import 'package:bearnshare/presentation/dashboard/bloc/dashboard_state.dart';
import 'package:bearnshare/presentation/dashboard/dash_board_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatefulWidget {
  final Widget child;

  const DashboardScreen({
    super.key,
    required this.child,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          body: widget.child,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 13,
              right: 16,
              bottom: 4,
            ),
            child: SafeArea(
              child: AppBottomNavBar(
                items: [
                  // home
                  BottomNavBarItem(
                    item: BottomNavItem.home,
                    status: state.selectedItem == BottomNavItem.home
                        ? BottomNavIconStatus.selected
                        : BottomNavIconStatus.disabled,
                    icon: Assets.icons.home.svg(
                        color: state.selectedItem == BottomNavItem.home
                            ? AppTheme.tertiaryColor
                            : AppTheme.bottomBarImgColor),
                    onPressed: () {
                      if (BottomNavItem.home == state.selectedItem) {
                        context
                            .read<DashboardBloc>()
                            .add(const DashboardTabToggle());
                      } else {
                        _handleNavigation(context, BottomNavItem.home, state);
                      }
                    },
                  ),

                  // search
                  BottomNavBarItem(
                    item: BottomNavItem.ledger,
                    status: state.selectedItem == BottomNavItem.ledger
                        ? BottomNavIconStatus.selected
                        : BottomNavIconStatus.disabled,
                    icon: Assets.icons.ledger.svg(
                        color: state.selectedItem == BottomNavItem.ledger
                            ? AppTheme.tertiaryColor
                            : AppTheme.bottomBarImgColor),
                    onPressed: () {
                      if (BottomNavItem.ledger == state.selectedItem) {
                        context
                            .read<DashboardBloc>()
                            .add(const DashboardTabToggle());
                      } else {
                        _handleNavigation(context, BottomNavItem.ledger, state);
                      }
                    },
                  ),
                  // notifications
                  BottomNavBarItem(
                    item: BottomNavItem.history,
                    status: state.selectedItem == BottomNavItem.history
                        ? BottomNavIconStatus.selected
                        : BottomNavIconStatus.disabled,
                    icon: Assets.icons.history.svg(
                        color: state.selectedItem == BottomNavItem.history
                            ? AppTheme.tertiaryColor
                            : AppTheme.bottomBarImgColor),
                    onPressed: () {
                      if (BottomNavItem.history == state.selectedItem) {
                        context
                            .read<DashboardBloc>()
                            .add(const DashboardTabToggle());
                      } else {
                        _handleNavigation(
                            context, BottomNavItem.history, state);
                      }
                    },
                  ),

                  // profile
                  BottomNavBarItem(
                    item: BottomNavItem.profile,
                    status: state.selectedItem == BottomNavItem.profile
                        ? BottomNavIconStatus.selected
                        : BottomNavIconStatus.disabled,
                    icon: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: ProfileCachedImageShimmer(
                        imageUrl: "",
                        isSelected: state.selectedItem == BottomNavItem.profile,
                        height: 24,
                        width: 24,
                        boxFit: BoxFit.cover,
                      ),
                    ),
                    onPressed: () {
                      if (BottomNavItem.profile == state.selectedItem) {
                        context
                            .read<DashboardBloc>()
                            .add(const DashboardTabToggle());
                      } else {
                        _handleNavigation(
                            context, BottomNavItem.profile, state);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleNavigation(
      BuildContext context, BottomNavItem selectedItem, DashboardState state) {
    switch (selectedItem) {
      case BottomNavItem.home:
        context
            .read<DashboardBloc>()
            .add(const DashboardTabChanged(BottomNavItem.home));
        context.go(DashboardRouter.homeRoute);
        break;
      case BottomNavItem.ledger:
        context
            .read<DashboardBloc>()
            .add(const DashboardTabChanged(BottomNavItem.ledger));
        context.go(DashboardRouter.ledgerRoute);
        break;
      case BottomNavItem.history:
        context
            .read<DashboardBloc>()
            .add(const DashboardTabChanged(BottomNavItem.history));
        context.go(DashboardRouter.historyRoute);
        break;
      case BottomNavItem.profile:
        context
            .read<DashboardBloc>()
            .add(const DashboardTabChanged(BottomNavItem.profile));
        context.go(DashboardRouter.profileRoute);
        break;
    }
  }
}
