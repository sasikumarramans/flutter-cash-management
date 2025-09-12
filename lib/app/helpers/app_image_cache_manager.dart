import 'package:cached_network_image/cached_network_image.dart';
import 'package:ev_flutter_app/app/helpers/custom_image_cache_manager.dart';
import 'package:flutter/material.dart';

class AppImageCacheManager {
  static final AppImageCacheManager _instance =
      AppImageCacheManager._internal();
  factory AppImageCacheManager() => _instance;
  AppImageCacheManager._internal();

  final _cacheManager = CustomImageCacheManager();

  CustomImageCacheManager get cacheManager => _cacheManager;

  Future<void> preloadImage(
    String imageUrl,
    BuildContext context, {
    int? maxHeight,
    int? maxWidth,
  }) {
    if (imageUrl.isEmpty) return Future.value();
    return precacheImage(
      CachedNetworkImageProvider(
        imageUrl,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        cacheKey: imageUrl,
        cacheManager: _cacheManager,
      ),
      context,
    ).catchError((error) {
      debugPrint('Error preloading image $imageUrl: $error');
      return;
    });
  }

  Future<void> preloadImages(
    List<String> imageUrls,
    BuildContext context, {
    int? maxHeight,
    int? maxWidth,
  }) async {
    final futures =
        imageUrls.where((url) => url.isNotEmpty).map((url) => preloadImage(
              url,
              context,
              maxHeight: maxHeight,
              maxWidth: maxWidth,
            ));

    await Future.wait(futures, eagerError: false);
  }

  void clearCache() {
    _cacheManager.emptyCache();
  }
}
