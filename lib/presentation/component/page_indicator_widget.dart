import 'package:flutter/material.dart';

class PageIndicatorWidget extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const PageIndicatorWidget(
      {super.key, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: isSelected ? 30 : 10,
        height: 10,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.grey.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
