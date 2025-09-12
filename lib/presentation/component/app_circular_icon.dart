import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:ev_flutter_app/app/theme/app_theme.dart';

enum BoxState { enabled, disabled, completed }

enum BoxType { filled, outlined }

class AppCircularIcon extends StatelessWidget {
  final Widget icon;
  final double size;
  final EdgeInsetsGeometry padding;
  final bool? showBadge;
  final Widget? badgeContent;
  final BoxState boxState;
  final BoxType boxType;
  final VoidCallback? onTap;

  final BoxDecoration? boxEnabledFilledDecoration;
  final BoxDecoration? boxEnabledOutlinedDecoration;
  final BoxDecoration? boxDisabledFilledDecoration;
  final BoxDecoration? boxDisabledOutlinedDecoration;
  final BoxDecoration? boxCompletedFilledDecoration;
  final BoxDecoration? boxCompletedOutlinedDecoration;

  final badges.BadgePosition? badgePosition;

  const AppCircularIcon({
    super.key,
    required this.icon,
    required this.size,
    required this.boxState,
    required this.boxType,
    this.padding = const EdgeInsets.all(4),
    this.showBadge = false,
    this.badgeContent,
    this.onTap,
    this.boxEnabledFilledDecoration,
    this.boxEnabledOutlinedDecoration,
    this.boxDisabledFilledDecoration,
    this.boxDisabledOutlinedDecoration,
    this.boxCompletedFilledDecoration,
    this.boxCompletedOutlinedDecoration,
    this.badgePosition,
  });

  BoxDecoration _getBoxDecoration() {
    switch (boxState) {
      case BoxState.enabled:
        return boxType == BoxType.filled
            ? (boxEnabledFilledDecoration ??
                AppTheme.boxEnabledFilledDecoration())
            : (boxEnabledOutlinedDecoration ??
                AppTheme.boxEnabledOutlinedDecoration());
      case BoxState.disabled:
        return boxType == BoxType.filled
            ? (boxDisabledFilledDecoration ??
                AppTheme.boxDisabledFilledDecoration())
            : (boxDisabledOutlinedDecoration ??
                AppTheme.boxDisabledOutlinedDecoration());
      case BoxState.completed:
        return boxType == BoxType.filled
            ? (boxCompletedFilledDecoration ??
                AppTheme.boxCompletedFilledDecoration())
            : (boxCompletedOutlinedDecoration ??
                AppTheme.boxCompletedOutlinedDecoration());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (boxState == BoxState.completed) ? onTap : null,
      child: badges.Badge(
        showBadge: showBadge ?? false,
        badgeContent: badgeContent,
        badgeAnimation: const badges.BadgeAnimation.slide(toAnimate: false),
        position: badgePosition ?? badges.BadgePosition.topStart(start: 1),
        badgeStyle: badges.BadgeStyle(
          shape: badges.BadgeShape.circle,
          badgeColor: Colors.white,
          padding: const EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Container(
          width: size + padding.horizontal,
          height: size + padding.vertical,
          decoration: _getBoxDecoration(),
          child: Padding(
            padding: padding,
            child: Center(
              child: SizedBox(
                width: size,
                height: size,
                child: icon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
