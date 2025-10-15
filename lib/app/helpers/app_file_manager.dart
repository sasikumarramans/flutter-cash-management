import 'dart:io';
import 'dart:typed_data';

import 'package:bearnshare/app/helpers/file_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

enum MediaExtension { jpg, png, mp4, mp3, pdf }

extension MediaExtensionExt on MediaExtension {
  String get value {
    switch (this) {
      case MediaExtension.jpg:
        return 'jpg';
      case MediaExtension.png:
        return 'png';
      case MediaExtension.mp4:
        return 'mp4';
      case MediaExtension.mp3:
        return 'mp3';
      case MediaExtension.pdf:
        return 'pdf';
    }
  }
}

class AppFileManager {
  static const String DIR_NEW_FABRIC = 'ugc/fabric/newFabric';
  static const String DIR_NEW_FABRIC_CROPPED = 'ugc/fabric/newFabric/cropped';
  static const String DIR_IMAGES = 'ugc/fabric/images';
  static const String DIR_VIDEOS = 'ugc/fabric/videos';
  static const String DIR_AUDIOS = 'ugc/fabric/audios';
  static const String DIR_FILES = 'ugc/fabric/files';

  final FileManager _fileManager = GetIt.I.get<FileManager>();
  final Uuid _uuid = const Uuid();

  Future<Map<String, String>> saveMedia(
      String directory, Uint8List data, MediaExtension extension) async {
    final id = _uuid.v4();
    final fileName = '$id.${extension.value}';
    final file = await _fileManager.saveFile(fileName, data, subDir: directory);
    return {id: file.path};
  }

  Future<Uint8List> readMedia(
      String directory, String id, MediaExtension extension) async {
    final fileName = '$id.${extension.value}';
    final dirPath = await _fileManager.getLocalDirectory(directory);
    final filePath = p.join(dirPath, fileName);
    return _fileManager.readFile(filePath);
  }

  Future<bool> mediaExists(
      String directory, String id, MediaExtension extension) async {
    final fileName = '$id.${extension.value}';
    final dirPath = await _fileManager.getLocalDirectory(directory);
    final filePath = p.join(dirPath, fileName);
    return _fileManager.fileExists(filePath);
  }

  Future<void> deleteMedia(
      String directory, String id, MediaExtension extension) async {
    final fileName = '$id.${extension.value}';
    final dirPath = await _fileManager.getLocalDirectory(directory);
    final filePath = p.join(dirPath, fileName);
    await _fileManager.deleteFile(filePath);
  }

  Future<void> deleteDirectory(String directory) async {
    final dirPath = await _fileManager.getLocalDirectory(directory);
    await _fileManager.deleteDirectory(dirPath);
  }

  Future<List<FileSystemEntity>> listMedia(String directory) async {
    final dirPath = await _fileManager.getLocalDirectory(directory);
    return _fileManager.listFiles(dirPath);
  }
}
