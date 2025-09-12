import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

class AppBadgeWidget extends StatelessWidget {
  final Widget badgeIcon;
  final Widget child;
  final badges.BadgeStyle badgeStyle;
  final badges.BadgePosition position;
  final bool? showBadge;

  const AppBadgeWidget({
    super.key,
    required this.badgeIcon,
    required this.child,
    this.badgeStyle = const badges.BadgeStyle(
      badgeColor: Colors.red,
      elevation: 0,
      padding: EdgeInsets.all(4),
    ),
    required this.position,
    this.showBadge = true,
  });

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: position,
      showBadge: showBadge!,
      badgeContent: badgeIcon,
      badgeStyle: badgeStyle,
      badgeAnimation: const badges.BadgeAnimation.size(
        disappearanceFadeAnimationDuration: Duration.zero,
      ),
      child: child,
    );
  }
}
