import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AnimatedImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final bool carouselAnimate;
  final Duration interval;
  final double overlayOpacity;
  final bool enableBlinkEffect;

  const AnimatedImageCarousel({
    super.key,
    required this.imageUrls,
    required this.carouselAnimate,
    this.interval = const Duration(seconds: 5),
    this.overlayOpacity = 0.5,
    this.enableBlinkEffect = false,
  });

  @override
  AnimatedImageCarouselState createState() => AnimatedImageCarouselState();
}

class AnimatedImageCarouselState extends State<AnimatedImageCarousel>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isAnimating = false;
  late AnimationController _blinkController;

  @override
  void initState() {
    super.initState();

    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    if (widget.carouselAnimate) {
      _startCarousel();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedImageCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.carouselAnimate != oldWidget.carouselAnimate) {
      widget.carouselAnimate ? _startCarousel() : _stopCarousel();
    }

    if (!widget.enableBlinkEffect) {
      _blinkController.stop();
    } else if (!_blinkController.isAnimating) {
      _blinkController.repeat(reverse: true);
    }
  }

  void _startCarousel() {
    if (!_isAnimating) {
      _isAnimating = true;
      _cycleImages();
    }
  }

  void _stopCarousel() {
    _isAnimating = false;
    _blinkController.stop();
  }

  void _cycleImages() async {
    while (_isAnimating) {
      await Future.delayed(widget.interval);
      if (!_isAnimating) break;
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.imageUrls.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              widget.imageUrls.isEmpty ? '' : widget.imageUrls[_currentIndex],
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        AnimatedBuilder(
          animation: _blinkController,
          builder: (context, child) {
            final effectiveOpacity = widget.enableBlinkEffect
                ? widget.overlayOpacity * _blinkController.value
                : widget.overlayOpacity;

            return Container(
              color: Colors.black.withValues(alpha: effectiveOpacity),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _stopCarousel();
    _blinkController.dispose();
    super.dispose();
  }
}
