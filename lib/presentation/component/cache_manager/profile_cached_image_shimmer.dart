import 'package:ev_flutter_app/app/theme/app_theme.dart';
import 'package:ev_flutter_app/generated/assets.gen.dart';
import 'package:ev_flutter_app/presentation/component/cache_manager/base_cached_image_shimmer.dart';
import 'package:ev_flutter_app/presentation/component/cache_manager/profile_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProfileCachedImageShimmer extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final bool isLoading;
  final BoxFit? boxFit;
  final double? width;
  final double? height;
  final bool isShowLoader;
  final bool isSelected;
  final Alignment alignment;

  const ProfileCachedImageShimmer({
    super.key,
    required this.imageUrl,
    this.name,
    this.isLoading = false,
    this.isSelected = false,
    this.isShowLoader = false,
    this.boxFit = BoxFit.contain,
    this.width,
    this.height,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildInitialsAvatar();
    }
    return BaseCachedImageShimmer(
      imageUrl: imageUrl,
      isLoading: isLoading,
      isShowLoader: isShowLoader,
      boxFit: boxFit,
      width: width,
      height: height,
      alignment: alignment,
      cacheManager: GetIt.I<ProfileCacheManager>().instance,
    );
  }

  Widget _buildInitialsAvatar() {
    return Container(
      width: width ?? 24,
      height: height ?? 24,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Assets.icons.profile.svg(
          color:
              isSelected ? AppTheme.tertiaryColor : AppTheme.bottomBarImgColor),
    );
  }
}
