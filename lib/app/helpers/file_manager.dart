import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class FileManager {
  Future<String> getLocalDirectory([String? subDir]) async {
    final baseDir = await getApplicationDocumentsDirectory();
    if (subDir != null) {
      final targetDir = Directory(p.join(baseDir.path, subDir));
      if (!(await targetDir.exists())) {
        await targetDir.create(recursive: true);
      }
      return targetDir.path;
    }
    return baseDir.path;
  }

  Future<File> saveFile(String fileName, Uint8List data,
      {String? subDir}) async {
    final directoryPath = await getLocalDirectory(subDir);
    final filePath = p.join(directoryPath, fileName);
    final file = File(filePath);
    await file.writeAsBytes(data);
    return file;
  }

  Future<bool> fileExists(String filePath) async {
    final file = File(filePath);
    return file.exists();
  }

  Future<Uint8List> readFile(String filePath) async {
    final file = File(filePath);
    return file.readAsBytes();
  }

  Future<void> deleteFile(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<void> deleteDirectory(String dirPath) async {
    final dir = Directory(dirPath);
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }

  Future<List<FileSystemEntity>> listFiles(String dirPath) async {
    final dir = Directory(dirPath);
    if (await dir.exists()) {
      return dir.list(recursive: false).toList();
    }
    return [];
  }

  Future<Uint8List> heavyReadFile(String filePath) async {
    return compute(_heavyReadFileSync, filePath);
  }
}

Uint8List _heavyReadFileSync(String filePath) {
  final file = File(filePath);
  return file.readAsBytesSync();
}
