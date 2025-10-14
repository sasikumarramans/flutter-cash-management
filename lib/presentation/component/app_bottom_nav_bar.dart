import 'package:ev_flutter_app/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

enum BottomNavItem {
  home,
  ledger,
  history,
  profile,
}

enum BottomNavIconStatus {
  enabled,
  selected,
  disabled,
  completed,
}

extension BottomNavItemExtension on BottomNavItem {
  String get label {
    switch (this) {
      case BottomNavItem.home:
        return 'Home';
      case BottomNavItem.ledger:
        return 'Ledgers';
      case BottomNavItem.history:
        return 'History';
      case BottomNavItem.profile:
        return 'Profile';
    }
  }
}

class AppBottomNavBar extends StatelessWidget {
  final List<BottomNavBarItem> items;

  const AppBottomNavBar({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        color: const Color(0x99000000),
        border: Border.all(
          width: 1,
          color: AppTheme.quaternaryTextColor,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: items.map((item) {
          final isSelected = item.status == BottomNavIconStatus.selected;

          Widget iconWidget;
          if (isSelected) {
            iconWidget = Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppTheme.tertiaryBackgroundColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: item.icon,
            );
          } else {
            iconWidget = item.icon;
          }

          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: item.onPressed,
              child: SizedBox(
                height: 50,
                child: Center(
                  child: iconWidget,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class BottomNavBarItem {
  final BottomNavItem item;
  final BottomNavIconStatus status;
  final VoidCallback onPressed;
  final Widget icon;

  BottomNavBarItem({
    required this.item,
    required this.status,
    required this.onPressed,
    required this.icon,
  });
}

class CreatePlusButton extends StatelessWidget {
  final Widget centerIcon;

  const CreatePlusButton({super.key, this.centerIcon = const SizedBox()});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 62,
            height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: AppTheme.iconButtonGradiant,
            ),
          ),
        ),
        Center(
          child: centerIcon,
        )
      ],
    );
  }
}
