import 'package:flutter/material.dart';
import 'package:ev_flutter_app/app/theme/app_theme.dart';

class ProcessItem {
  final String label;
  final VoidCallback onTap;
  final Color? color;

  ProcessItem({required this.label, required this.onTap, this.color});
}

class ProcessAlertDialog extends StatelessWidget {
  final Widget icon;
  final String title;
  final String? subtitle;
  final List<ProcessItem> actions;

  const ProcessAlertDialog({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 24),
        icon,
        const SizedBox(height: 16),
        Text(
          title,
          style: AppTheme.simpleWhiteTextStyle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          Text(
            subtitle!,
            style: AppTheme.simpleWhiteTextStyle.copyWith(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: AppTheme.secondaryLabelColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
        const SizedBox(height: 16),
        ListView.builder(
          padding: const EdgeInsets.all(4),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: actions.length,
          itemBuilder: (context, index) {
            final action = actions[index];
            return GestureDetector(
              onTap: action.onTap,
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Text(
                  action.label,
                  style: AppTheme.simpleWhiteTextStyle.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: action.color ?? Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
