import 'package:flutter/material.dart';

class OutlineRippleButton extends StatefulWidget {
  const OutlineRippleButton({super.key});

  @override
  State<OutlineRippleButton> createState() => _OutlineRippleButtonState();
}

class _OutlineRippleButtonState extends State<OutlineRippleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildRing() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        final scale = 1 + _animation.value * 1.0;
        final opacity = 1.0 - _animation.value;

        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: opacity,
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3),
                  width: 3,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildRing(), // Outlined ripple ring
        ],
      ),
    );
  }
}
