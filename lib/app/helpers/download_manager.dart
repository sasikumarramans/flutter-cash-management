import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

enum FileType {
  video,
  image,
  audio,
}

class DownloadManager {
  final Dio _dio = Dio();
  final Uuid _uuid = const Uuid();

  Future<String> downloadFile(String url, FileType fileType) async {
    try {
      Directory? directory;

      if (kIsWeb) {
        throw UnsupportedError("File download is not supported on the web.");
      } else if (Platform.isAndroid || Platform.isIOS) {
        directory = await _getPlatformSpecificDirectory(fileType);
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        throw Exception("Could not determine a valid directory.");
      }

      String fileName = _extractFileNameFromUrl(url);
      String uniqueFileName = _generateUniqueFileName(fileName);
      String savePath = path.join(directory.path, uniqueFileName);
      print("savePath: $savePath");

      await _dio.download(url, savePath);
      return savePath;
    } catch (e) {
      debugPrint("Error downloading file: $e");
      throw Exception("Failed to download file: $e");
    }
  }

  Future<void> deleteFile(String filePath) async {
    final file = File(filePath);
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      throw Exception("Failed to delete file: $e");
    }
  }

  Future<void> clearAllDownloadedFiles(FileType fileType) async {
    try {
      Directory? directory = await _getPlatformSpecificDirectory(fileType);

      if (directory != null && await directory.exists()) {
        List<FileSystemEntity> files = directory.listSync();
        for (var file in files) {
          if (file is File) {
            await file.delete();
          }
        }
      }
    } catch (e) {
      throw Exception("Failed to clear downloaded files: $e");
    }
  }

  Future<Directory?> _getPlatformSpecificDirectory(FileType fileType) async {
    if (Platform.isAndroid) {
      return await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      switch (fileType) {
        case FileType.video:
        case FileType.image:
          return await getApplicationDocumentsDirectory();
        case FileType.audio:
          return await getApplicationSupportDirectory();
      }
    }
    return null;
  }

  String _extractFileNameFromUrl(String url) {
    Uri uri = Uri.parse(url);
    return path.basename(uri.path);
  }

  String _generateUniqueFileName(String fileName) {
    String extension = path.extension(fileName);
    String nameWithoutExtension = path.basenameWithoutExtension(fileName);
    return "${nameWithoutExtension}_${_uuid.v4()}$extension";
  }
}
