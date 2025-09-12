import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ev_flutter_app/presentation/component/cache_manager/base_cached_image_shimmer.dart';
import 'package:ev_flutter_app/presentation/component/cache_manager/drafts_cache_manager.dart';

class DraftsCachedImageShimmer extends StatelessWidget {
  final String? imageUrl;
  final bool isLoading;
  final BoxFit? boxFit;
  final double? width;
  final double? height;
  final bool isShowLoader;
  final Alignment alignment;

  const DraftsCachedImageShimmer({
    super.key,
    required this.imageUrl,
    this.isLoading = false,
    this.isShowLoader = false,
    this.boxFit = BoxFit.contain,
    this.width,
    this.height,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCachedImageShimmer(
      imageUrl: imageUrl,
      isLoading: isLoading,
      isShowLoader: isShowLoader,
      boxFit: boxFit,
      width: width,
      height: height,
      alignment: alignment,
      cacheManager: GetIt.I<DraftsCacheManager>().instance,
    );
  }
}
