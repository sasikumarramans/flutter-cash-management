import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shimmer/shimmer.dart';

class BaseCachedImageShimmer extends StatelessWidget {
  final String? imageUrl;
  final bool isLoading;
  final BoxFit? boxFit;
  final double? width;
  final double? height;
  final bool isShowLoader;
  final Alignment alignment;
  final BaseCacheManager cacheManager;

  const BaseCachedImageShimmer({
    required this.imageUrl,
    required this.cacheManager,
    this.isLoading = false,
    this.isShowLoader = false,
    this.boxFit = BoxFit.contain,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading || imageUrl == null || (imageUrl?.isEmpty ?? true)) {
      return SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            ShimmerPlaceholder(width: width, height: height),
            if (isShowLoader)
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.only(right: 0),
                  height: 70,
                  width: 70,
                  child: const CircularProgressIndicator(),
                ),
              )
          ],
        ),
      );
    }

    final uri = Uri.tryParse(imageUrl!);
    if (uri == null || uri.host.isEmpty) {
      return ShimmerPlaceholder(width: width, height: height);
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      placeholder: (context, url) =>
          ShimmerPlaceholder(width: width, height: height),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      cacheManager: cacheManager,
      fit: boxFit,
      width: width,
      height: height,
      alignment: alignment,
    );
  }
}

class ShimmerPlaceholder extends StatelessWidget {
  final double? width;
  final double? height;

  const ShimmerPlaceholder({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF272727),
      highlightColor: const Color.fromARGB(255, 33, 33, 33),
      child: Container(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        color: const Color(0xFF272727),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.only(right: 30),
            height: 70,
            width: 70,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
