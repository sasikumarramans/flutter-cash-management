import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ev_flutter_app/app/theme/app_theme.dart';
import 'package:ev_flutter_app/presentation/component/cache_manager/profile_cache_manager.dart';

class ProfileAvatar extends StatelessWidget {
  final String name;
  final String? profilePicture;
  final double radius;
  final Color? backgroundColor;
  final _profileCacheManager = GetIt.I<ProfileCacheManager>().instance;

  ProfileAvatar(
      {super.key,
      required this.name,
      this.profilePicture,
      this.radius = 16.0,
      this.backgroundColor = AppTheme.tertiaryColor});

  String _getInitials(String name) {
    if (name.trim().isEmpty) return "";
    final parts = name.trim().split(" ");
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    } else {
      return (parts[0].substring(0, 1) + parts[1].substring(0, 1))
          .toUpperCase();
    }
  }

  Widget _buildInitialsAvatar() {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: Text(
        _getInitials(name),
        style: TextStyle(
          color: Colors.white,
          fontSize: radius * 0.8,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<bool> isImageAccessible(String url) async {
    try {
      final dio = GetIt.I<Dio>();
      final response = await dio.head(url,
          options: Options(
              followRedirects: false, validateStatus: (status) => true));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isImageAccessible(profilePicture ?? ""),
      builder: (context, snapshot) {
        final isAccessible = snapshot.data ?? false;
        if (profilePicture != null &&
            profilePicture!.isNotEmpty &&
            snapshot.connectionState == ConnectionState.done &&
            isAccessible) {
          return CircleAvatar(
            radius: radius,
            backgroundColor: Colors.transparent,
            child: CachedNetworkImage(
              cacheManager: _profileCacheManager,
              imageUrl: profilePicture!,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => SizedBox(
                width: radius,
                height: radius,
                child: const CircularProgressIndicator(strokeWidth: 2.0),
              ),
              errorWidget: (context, url, error) => _buildInitialsAvatar(),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return CircleAvatar(
            radius: radius,
            backgroundColor: backgroundColor,
            child: SizedBox(
              width: radius,
              height: radius,
              child: const CircularProgressIndicator(strokeWidth: 2.0),
            ),
          );
        } else {
          return _buildInitialsAvatar();
        }
      },
    );
  }
}
