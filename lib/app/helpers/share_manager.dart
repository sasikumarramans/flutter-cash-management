import 'dart:io';

import 'package:bearnshare/app/helpers/app_snack_bar_manager.dart';
import 'package:bearnshare/app/helpers/download_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareManager {
  Future<void> shareFile(String filePath,
      {String? subject, String? text, required FileType fileType}) async {
    try {
      GetIt.I<AppSnackBarManager>().showLoading();
      print(filePath);
      final shareablePath = await _prepareFileForSharing(filePath, fileType);
      final mimeType = _getMimeType(filePath, fileType);
      print(shareablePath);
      final xFile = XFile(shareablePath, mimeType: mimeType);
      GetIt.I<AppSnackBarManager>().hideLoading();
      await Share.shareXFiles([xFile], subject: subject);
    } catch (e) {
      debugPrint("Failed to share file: $e");
      rethrow;
    }
  }

  Future<String> _prepareFileForSharing(
      String filePath, FileType fileType) async {
    final file = File(filePath);
    if (!file.existsSync()) throw Exception("File not found: $filePath");
    final tempDir = await getTemporaryDirectory();
    final ext = path.extension(filePath); // includes the dot, e.g., ".mp4"
    final newFileName = '${"report"}$ext';
    final newFilePath = path.join(tempDir.path, newFileName);
    return (await file.copy(newFilePath)).path;
  }

  String? _getMimeType(String filePath, FileType fileType) {
    String extension = filePath.split('.').last.toLowerCase();
    switch (fileType) {
      case FileType.video:
        switch (extension) {
          case 'mp4':
            return 'video/mp4';
          case 'mov':
            return 'video/quicktime';
          case 'mkv':
            return 'video/x-matroska';

          default:
            return null;
        }
      case FileType.image:
        switch (extension) {
          case 'jpg':
          case 'jpeg':
            return 'image/jpeg';
          case 'png':
            return 'image/png';
          case 'gif':
            return 'image/gif';
          default:
            return null;
        }
      case FileType.audio:
        switch (extension) {
          case 'mp3':
            return 'audio/mpeg';
          case 'wav':
            return 'audio/wav';
          default:
            return null;
        }
      case FileType.pdf:
        return 'application/pdf';
    }
  }
}
