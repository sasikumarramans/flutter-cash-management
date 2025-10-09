import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveManager {
  static const String _hiveStorageKey = 'hiveStorageKey';
  static const String _vaultBoxName = 'appVaultBox';

  static const String userSessionTokenKey = 'user_token';
  static const String appSessionId = 'app_session_id';
  static const String userIdKey = 'user_id';
  static const String notificationToken = 'notificationToken';

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> initHive() async {
    await Hive.initFlutter();

    String? encryptionKeyString;
    try {
      encryptionKeyString = await _secureStorage.read(key: _hiveStorageKey);
    } catch (e) {
      await _secureStorage.deleteAll();
    }
    if (encryptionKeyString == null) {
      final key = Hive.generateSecureKey();
      encryptionKeyString = base64UrlEncode(key);
      await _secureStorage.write(
          key: _hiveStorageKey, value: encryptionKeyString);
    }

    final encryptionKeyUint8List = base64Url.decode(encryptionKeyString);

    if (!Hive.isBoxOpen(_vaultBoxName)) {
      await Hive.openBox(
        _vaultBoxName,
        encryptionCipher: HiveAesCipher(encryptionKeyUint8List),
      );
    }
  }

  Future<void> saveToHive<T>(String key, T value) async {
    final encryptedBox = Hive.box(_vaultBoxName);
    await encryptedBox.put(key, value);
  }

  T? getFromHive<T>(String key) {
    final encryptedBox = Hive.box(_vaultBoxName);
    return encryptedBox.get(key) as T?;
  }

  Future<void> closeHive() async {
    if (Hive.isBoxOpen(_vaultBoxName)) {
      await Hive.box(_vaultBoxName).close();
    }
  }

  Future<void> clearHive() async {
    try {
      if (Hive.isBoxOpen(_vaultBoxName)) {
        await Hive.box(_vaultBoxName).clear();
      }
    } catch (e) {
      throw HiveError('Failed to clear Hive boxes: $e');
    }
  }
}
