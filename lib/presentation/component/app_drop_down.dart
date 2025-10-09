import 'package:flutter/material.dart';
import 'package:ev_flutter_app/app/theme/app_theme.dart';

/// Represents one menu entry for [AppDropdownButton].
/// You can pass any widget as [child] and an associated [onTap] callback.
class AppDropdownItem {
  final Widget child;
  final VoidCallback onTap;
  final bool enabled;

  const AppDropdownItem({
    required this.child,
    required this.onTap,
    this.enabled = true,
  });
}

class AppDropDown extends StatefulWidget {
  /// The widget that acts as the tappable anchor (e.g., a 3-dot icon).
  final Widget anchor;

  /// List of custom menu entries.
  final List<AppDropdownItem> items;

  /// Whether to animate the anchor when menu opens/closes.
  final bool enableAnimation;

  /// Duration for the optional anchor animation.
  final Duration? animationDuration;

  /// Visual customization (optional).
  /// If provided, overrides [AppTheme.dropdownMenuStyle].
  final MenuStyle? menuStyle;

  /// If provided, overrides [AppTheme.dropdownButtonStyle] used for each item.
  final ButtonStyle? itemButtonStyle;

  /// Anchor padding area to increase tap target without changing [anchor] layout.
  final EdgeInsetsGeometry? anchorPadding;

  /// Offset to position the menu relative to the anchor.
  /// Defaults to [AppTheme.dropdownOffset].
  final Offset? alignmentOffset;

  /// Optional border radius for the popup menu.
  final BorderRadius? borderRadius;

  /// Optional border color for the popup menu.
  final Color? borderColor;

  /// Optional border width for the popup menu.
  final double? borderWidth;

  /// Optional background color for the popup surface.
  final Color? backgroundColor;

  /// Optional elevation for the popup surface.
  final double? elevation;

  const AppDropDown({
    super.key,
    required this.anchor,
    required this.items,
    this.enableAnimation = false,
    this.animationDuration = AppTheme.animationDuration,
    this.menuStyle,
    this.itemButtonStyle,
    this.anchorPadding,
    this.alignmentOffset,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.backgroundColor,
    this.elevation,
  });

  @override
  AppDropDownState createState() => AppDropDownState();
}

class AppDropDownState extends State<AppDropDown>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleOpen(MenuController controller) {
    if (widget.enableAnimation) _controller.forward();
    controller.open();
  }

  void _handleClose() {
    if (widget.enableAnimation) _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final baseMenuStyle = widget.menuStyle ?? AppTheme.dropdownMenuStyle;

    final shape = RoundedRectangleBorder(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
      side: (widget.borderColor != null || widget.borderWidth != null)
          ? BorderSide(
              color: widget.borderColor ?? Colors.transparent,
              width: widget.borderWidth ?? 1,
            )
          : BorderSide.none,
    );

    MenuStyle effectiveMenuStyle = baseMenuStyle;
    if (widget.borderRadius != null ||
        widget.borderColor != null ||
        widget.borderWidth != null ||
        widget.backgroundColor != null ||
        widget.elevation != null) {
      effectiveMenuStyle = effectiveMenuStyle.copyWith(
        shape: WidgetStatePropertyAll<OutlinedBorder>(shape),
        backgroundColor: widget.backgroundColor != null
            ? WidgetStatePropertyAll<Color?>(widget.backgroundColor)
            : null,
        elevation: widget.elevation != null
            ? WidgetStatePropertyAll<double?>(widget.elevation)
            : null,
      );
    }

    final ButtonStyle effectiveItemStyle =
        widget.itemButtonStyle ?? AppTheme.dropdownButtonStyle;

    return MenuAnchor(
      alignmentOffset: widget.alignmentOffset ?? AppTheme.dropdownOffset,
      builder: (context, controller, child) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => _handleOpen(controller),
          child: Padding(
            padding: widget.anchorPadding ?? const EdgeInsets.all(10.0),
            child: widget.anchor,
          ),
        );
      },
      style: effectiveMenuStyle,
      menuChildren: widget.items.map((item) {
        return MenuItemButton(
          onPressed: item.enabled ? item.onTap : null,
          style: effectiveItemStyle,
          child: item.child,
        );
      }).toList(),
      onClose: _handleClose,
    );
  }
}
