import 'package:flutter/material.dart';
import 'package:ev_flutter_app/app/theme/app_theme.dart';
import 'package:ev_flutter_app/generated/assets.gen.dart';

enum BottomNavItem {
  home,
  search,
  generateContent,
  notifications,
  profile,
}

extension BottomNavItemExtension on BottomNavItem {
  String get label {
    switch (this) {
      case BottomNavItem.home:
        return 'Home';
      case BottomNavItem.search:
        return 'Search';
      case BottomNavItem.generateContent:
        return '';
      case BottomNavItem.notifications:
        return 'Notifications';
      case BottomNavItem.profile:
        return 'Profile';
    }
  }
}

class AppBottomNavBar extends StatefulWidget {
  final int itemCount;
  final int? currentIndex;
  final List<MapEntry<SvgGenImage, BottomNavItem>> items;
  final Widget? centerIcon;
  final TextStyle? unselectedTextStyle;
  final TextStyle? selectedTextStyle;
  final TextStyle? disabledTextStyle;
  final Color? unselectedIconColor;
  final Color? selectedIconColor;
  final Color? disabledIconColor;
  final Color? backgroundColor;
  final ValueChanged<int>? onItemSelected;
  final Duration animationDuration;
  final Curve animationCurve;
  final List<int>? disabledIndices;

  const AppBottomNavBar({
    super.key,
    required this.itemCount,
    required this.items,
    this.centerIcon,
    this.currentIndex,
    this.onItemSelected,
    this.unselectedTextStyle,
    this.selectedTextStyle,
    this.disabledTextStyle,
    this.unselectedIconColor,
    this.selectedIconColor,
    this.disabledIconColor,
    this.backgroundColor,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.disabledIndices,
  });

  @override
  AppBottomNavBarState createState() => AppBottomNavBarState();
}

class AppBottomNavBarState extends State<AppBottomNavBar>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _glowAnimation;

  TextStyle get unselectedTextStyle =>
      widget.unselectedTextStyle ??
      AppTheme.dashboardBottomBarUnselectedTextStyle;

  TextStyle get selectedTextStyle =>
      widget.selectedTextStyle ?? AppTheme.dashboardBottomBarSelectedTextStyle;

  TextStyle get disabledTextStyle =>
      widget.disabledTextStyle ?? AppTheme.dashboardBottomBarDisabledTextStyle;

  Color get unselectedIconColor =>
      widget.unselectedIconColor ??
      AppTheme.dashboardBottomBarUnselectedIconColor;

  Color get selectedIconColor =>
      widget.selectedIconColor ?? AppTheme.dashboardBottomBarSelectedIconColor;

  Color get disabledIconColor =>
      widget.disabledIconColor ?? AppTheme.dashboardBottomBarDisabledIconColor;

  Color get backgroundColor =>
      widget.backgroundColor ?? AppTheme.dashboardBottomBarBackgroundColor;

  bool isItemDisabled(int index) {
    return widget.disabledIndices?.contains(index) ?? false;
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex ?? 0;
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _glowAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );
    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (!isItemDisabled(index)) {
      widget.onItemSelected?.call(index);
    }
  }

  @override
  void didUpdateWidget(AppBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != null && widget.currentIndex != _selectedIndex) {
      setState(() {
        _selectedIndex = widget.currentIndex!;
      });
      _animationController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(widget.itemCount, (index) {
          if (widget.centerIcon != null && index == (widget.itemCount ~/ 2)) {
            return Expanded(
                child: GestureDetector(
                    onTap: () => widget.onItemSelected?.call(index),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        widget.centerIcon!,
                        const SizedBox(height: 7),
                      ],
                    )));
          }

          bool isSelected = _selectedIndex == index;
          bool isDisabled = isItemDisabled(index);
          Color iconColor = isDisabled
              ? disabledIconColor
              : isSelected
                  ? selectedIconColor
                  : unselectedIconColor;

          return Expanded(
            child: GestureDetector(
              onTap: () => _onItemTapped(index),
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _glowAnimation,
                    builder: (context, child) {
                      return Container(
                        decoration: isSelected && !isDisabled
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: selectedIconColor.withValues(
                                        alpha: 0.4),
                                    blurRadius: _glowAnimation.value,
                                    spreadRadius: _glowAnimation.value,
                                  ),
                                ],
                              )
                            : null,
                        child: widget.items[index].key.svg(
                          colorFilter: ColorFilter.mode(
                            iconColor,
                            BlendMode.srcIn,
                          ),
                          height: 22,
                          width: 22,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.items[index].value.label,
                    style: isDisabled
                        ? disabledTextStyle
                        : isSelected
                            ? selectedTextStyle
                            : unselectedTextStyle,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
