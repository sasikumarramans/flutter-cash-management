import 'dart:io';

import 'package:bearnshare/app/helpers/app_snack_bar_manager.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:get_it/get_it.dart';

class GalleryManager {
  Future<bool> saveLocalFileToGallery(
    String filePath, {
    String? album,
    bool? showError,
  }) async {
    _ensurePlatformSupported();
    try {
      final lower = filePath.toLowerCase();
      final isVideo = _looksLikeVideo(lower);

      if (isVideo) {
        await Gal.putVideo(filePath, album: album);
      } else {
        await Gal.putImage(filePath, album: album);
      }

      return true;
    } on GalException catch (e) {
      if (showError ?? true) {
        GetIt.I<AppSnackBarManager>().showError("Failed to download");
      }
      debugPrint('Gallery (gal) save error: ${e.type} ${e.toString()}');
      return false;
    } catch (e) {
      debugPrint('Gallery save error: $e');
      return false;
    }
  }

  Future<void> openSystemGallery() async {
    _ensurePlatformSupported();
    try {
      await Gal.open();
    } catch (e) {
      debugPrint('Open gallery error: $e');
    }
  }

  bool _looksLikeVideo(String path) {
    const videoExts = <String>{
      '.mp4',
      '.mov',
      '.m4v',
      '.avi',
      '.mkv',
      '.webm',
      '.3gp',
      '.3gpp',
      '.3g2'
    };
    final dot = path.lastIndexOf('.');
    if (dot == -1) return false;
    final ext = path.substring(dot);
    return videoExts.contains(ext);
  }

  void _ensurePlatformSupported() {
    if (kIsWeb) {
      throw UnsupportedError('Saving to gallery is not supported on web.');
    }
    if (!(Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isMacOS ||
        Platform.isWindows ||
        Platform.isLinux)) {
      throw UnsupportedError('Unsupported platform for gal.');
    }
  }
}
