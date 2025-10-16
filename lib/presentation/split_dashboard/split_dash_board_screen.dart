import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/generated/assets.gen.dart';
import 'package:bearnshare/presentation/component/app_bottom_nav_bar.dart';
import 'package:bearnshare/presentation/component/cache_manager/profile_cached_image_shimmer.dart';
import 'package:bearnshare/presentation/split_dashboard/bloc/split_dashboard_bloc.dart';
import 'package:bearnshare/presentation/split_dashboard/bloc/split_dashboard_event.dart';
import 'package:bearnshare/presentation/split_dashboard/bloc/split_dashboard_state.dart';
import 'package:bearnshare/presentation/split_dashboard/split_dash_board_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplitDashBoardScreen extends StatefulWidget {
  final Widget child;

  const SplitDashBoardScreen({
    super.key,
    required this.child,
  });

  @override
  State<SplitDashBoardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<SplitDashBoardScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
    return BlocBuilder<SplitDashboardBloc, SplitDashboardState>(
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
              child: SplitBottomNavBar(
                items: [
                  // home
                  SplitBottomNavBarItem(
                    item: SplitBottomNavItem.home,
                    status: state.selectedItem == SplitBottomNavItem.home
                        ? BottomNavIconStatus.selected
                        : BottomNavIconStatus.disabled,
                    icon: Assets.icons.home.svg(
                        color: state.selectedItem == SplitBottomNavItem.home
                            ? AppTheme.tertiaryColor
                            : AppTheme.bottomBarImgColor),
                    onPressed: () {
                      if (SplitBottomNavItem.home == state.selectedItem) {
                        context
                            .read<SplitDashboardBloc>()
                            .add(const SplitDashboardTabToggle());
                      } else {
                        _handleNavigation(
                            context, SplitBottomNavItem.home, state);
                      }
                    },
                  ),

                  // group
                  SplitBottomNavBarItem(
                    item: SplitBottomNavItem.group,
                    status: state.selectedItem == SplitBottomNavItem.group
                        ? BottomNavIconStatus.selected
                        : BottomNavIconStatus.disabled,
                    icon: Assets.icons.group.svg(
                        color: state.selectedItem == SplitBottomNavItem.group
                            ? AppTheme.tertiaryColor
                            : AppTheme.bottomBarImgColor),
                    onPressed: () {
                      if (SplitBottomNavItem.group == state.selectedItem) {
                        context
                            .read<SplitDashboardBloc>()
                            .add(const SplitDashboardTabToggle());
                      } else {
                        _handleNavigation(
                            context, SplitBottomNavItem.group, state);
                      }
                    },
                  ),
                  // friends
                  SplitBottomNavBarItem(
                    item: SplitBottomNavItem.friends,
                    status: state.selectedItem == SplitBottomNavItem.friends
                        ? BottomNavIconStatus.selected
                        : BottomNavIconStatus.disabled,
                    icon: Assets.icons.friends.svg(
                        color: state.selectedItem == SplitBottomNavItem.friends
                            ? AppTheme.tertiaryColor
                            : AppTheme.bottomBarImgColor),
                    onPressed: () {
                      if (SplitBottomNavItem.friends == state.selectedItem) {
                        context
                            .read<SplitDashboardBloc>()
                            .add(const SplitDashboardTabToggle());
                      } else {
                        _handleNavigation(
                            context, SplitBottomNavItem.friends, state);
                      }
                    },
                  ),

                  // profile
                  SplitBottomNavBarItem(
                    item: SplitBottomNavItem.profile,
                    status: state.selectedItem == SplitBottomNavItem.profile
                        ? BottomNavIconStatus.selected
                        : BottomNavIconStatus.disabled,
                    icon: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: ProfileCachedImageShimmer(
                        imageUrl: "",
                        isSelected:
                            state.selectedItem == SplitBottomNavItem.profile,
                        height: 24,
                        width: 24,
                        boxFit: BoxFit.cover,
                      ),
                    ),
                    onPressed: () {
                      if (SplitBottomNavItem.profile == state.selectedItem) {
                        context
                            .read<SplitDashboardBloc>()
                            .add(const SplitDashboardTabToggle());
                      } else {
                        _handleNavigation(
                            context, SplitBottomNavItem.profile, state);
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

  void _handleNavigation(BuildContext context, SplitBottomNavItem selectedItem,
      SplitDashboardState state) {
    switch (selectedItem) {
      case SplitBottomNavItem.home:
        context
            .read<SplitDashboardBloc>()
            .add(const SplitDashboardTabChanged(SplitBottomNavItem.home));
        context.go(SplitDashboardRouter.splitHomeRoute);
        break;
      case SplitBottomNavItem.group:
        context
            .read<SplitDashboardBloc>()
            .add(const SplitDashboardTabChanged(SplitBottomNavItem.group));
        context.go(SplitDashboardRouter.splitGroupRoute);
        break;
      case SplitBottomNavItem.friends:
        context
            .read<SplitDashboardBloc>()
            .add(const SplitDashboardTabChanged(SplitBottomNavItem.friends));
        context.go(SplitDashboardRouter.friendsRoute);
        break;
      case SplitBottomNavItem.profile:
        context
            .read<SplitDashboardBloc>()
            .add(const SplitDashboardTabChanged(SplitBottomNavItem.profile));
        context.go(SplitDashboardRouter.splitProfileRoute);
        break;
    }
  }
}
