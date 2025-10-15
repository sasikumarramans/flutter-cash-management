import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class GentleMessage extends StatelessWidget {
  const GentleMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.gentleMessageBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(Icons.info),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Sorry, we couldn’t find this emotion. Can you pick something close from the list below?",
              style: AppTheme.gentleMessageTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
