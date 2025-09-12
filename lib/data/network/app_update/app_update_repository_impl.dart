import 'dart:convert';
import 'dart:io';

import 'package:ev_flutter_app/domain/app_update/app_update_repository.dart';
import 'package:ev_flutter_app/domain/app_update/model/app_update_info.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart' as android_update;
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateRepositoryImpl implements AppUpdateRepository {
  static String androidMinRequiredVersion = "android_min_required_version";
  static String iosMinRequiredVersion = "ios_min_required_version";
  static String androidLatestVersion = "android_latest_version";
  static String iosLatestVersion = "ios_latest_version";
  static String androidUrl = "android_update_url";
  static String iosUrl = "ios_update_url";
  static String androidUpdateMessage = "android_update_message";
  static String iosUpdateMessage = "ios_update_message";
  static String androidIsForceUpdate = "android_is_force_update";
  static String iosIsForceUpdate = "ios_is_force_update";
  static String androidLastForceUpdateVersion =
      "android_last_force_update_version";
  static String iosLastForceUpdateVersion = "ios_last_force_update_version";
  final _remoteConfig = FirebaseRemoteConfig.instance;
  final android_update.InAppUpdate? _inAppUpdate;

  AppUpdateRepositoryImpl({android_update.InAppUpdate? inAppUpdate})
      : _inAppUpdate = inAppUpdate;

  @override
  Future<AppUpdateModel> getUpdateInfo() async {
    try {
      _remoteConfig.settings.minimumFetchInterval =
          const Duration(milliseconds: 0);
      String flavor =
          const String.fromEnvironment('FLAVOR', defaultValue: 'prod');
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(minutes: 1),
        ),
      );
      await _remoteConfig.fetchAndActivate();
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      String key = "android_$flavor";
      if (Platform.isIOS) {
        key = "ios_$flavor";
      }
      var json = _remoteConfig.getString(key);
      final updateConfig = jsonDecode(json);
      final minRequiredVersion = Platform.isAndroid
          ? updateConfig[androidMinRequiredVersion] ?? ""
          : updateConfig[iosMinRequiredVersion] ?? "";
      final latestVersion = Platform.isAndroid
          ? updateConfig[androidLatestVersion] ?? ""
          : updateConfig[iosLatestVersion] ?? "";
      final androidUpdateUrl = updateConfig[androidUrl] ?? "";
      final iosUpdateUrl = updateConfig[iosUrl] ?? "";
      final updateMessage = Platform.isAndroid
          ? updateConfig[androidUpdateMessage] ?? ""
          : updateConfig[iosUpdateMessage] ?? "";

      final isGlobalForceUpdate = Platform.isAndroid
          ? updateConfig[androidIsForceUpdate]
          : updateConfig[iosIsForceUpdate];
      final lastForceUpdateVersion = Platform.isAndroid
          ? updateConfig[androidLastForceUpdateVersion] ?? ""
          : updateConfig[iosLastForceUpdateVersion] ?? "";

      final needsForceUpdate =
          _isVersionLower(currentVersion, lastForceUpdateVersion);
      final isUpdateRequired = needsForceUpdate || isGlobalForceUpdate;
      final isUpdateAvailable = _isVersionLower(currentVersion, latestVersion);

      return AppUpdateModel(
        currentVersion: currentVersion,
        minRequiredVersion: minRequiredVersion,
        latestVersion: latestVersion,
        androidUpdateUrl: androidUpdateUrl ?? "",
        iosUpdateUrl: iosUpdateUrl ?? "",
        updateMessage: updateMessage ?? "",
        isUpdateRequired: isUpdateRequired,
        isUpdateAvailable: isUpdateAvailable,
      );
    } catch (e) {
      return AppUpdateModel(
        currentVersion: '1.0.0',
        minRequiredVersion: '1.0.0',
        latestVersion: '1.0.0',
        androidUpdateUrl: '',
        iosUpdateUrl: '',
        updateMessage: 'Please update to the latest version.',
        isUpdateRequired: false,
        isUpdateAvailable: false,
      );
    }
  }

  @override
  Future<bool> performSoftUpdate(BuildContext context) async {
    try {
      if (Platform.isAndroid) {
        return await _performAndroidSoftUpdate(context);
      } else if (Platform.isIOS) {
        return await _performIosUpdate();
      }
      return false;
    } catch (e) {
      debugPrint('Error performing update: $e');
      return false;
    }
  }

  @override
  Future<bool> performForceUpdate(BuildContext context) async {
    try {
      if (Platform.isAndroid) {
        return await _performAndroidForceUpdate(context);
      } else if (Platform.isIOS) {
        return await _performIosUpdate();
      }
      return false;
    } catch (e) {
      debugPrint('Error performing update: $e');
      return false;
    }
  }

  Future<bool> _performAndroidSoftUpdate(BuildContext context) async {
    if (_inAppUpdate != null) {
      try {
        final appUpdateInfo = await InAppUpdate.checkForUpdate();
        if (appUpdateInfo.updateAvailability ==
            android_update.UpdateAvailability.updateAvailable) {
          await InAppUpdate.startFlexibleUpdate();
          return true;
        }
      } catch (e) {
        debugPrint('In-app update failed: $e');
      }
    }
    final androidUrl = _remoteConfig.getString('android_update_url');
    return await _launchUrl(androidUrl);
  }

  Future<bool> _performAndroidForceUpdate(BuildContext context) async {
    if (_inAppUpdate != null) {
      try {
        final appUpdateInfo = await InAppUpdate.checkForUpdate();
        if (appUpdateInfo.updateAvailability ==
            android_update.UpdateAvailability.updateAvailable) {
          await InAppUpdate.performImmediateUpdate();
          return true;
        }
      } catch (e) {
        debugPrint('In-app update failed: $e');
      }
    }
    final androidUrl = _remoteConfig.getString('android_update_url');
    return await _launchUrl(androidUrl);
  }

  Future<bool> _performIosUpdate() async {
    final iosUrl = _remoteConfig.getString('ios_update_url');
    return await _launchUrl(iosUrl);
  }

  Future<bool> _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      return false;
    } catch (e) {
      debugPrint('Error launching URL: $e');
      return false;
    }
  }

  bool _isVersionLower(String version1, String version2) {
    final v1Parts = _parseVersion(version1);
    final v2Parts = _parseVersion(version2);
    for (int i = 0; i < v1Parts.length && i < v2Parts.length; i++) {
      if (v1Parts[i] < v2Parts[i]) {
        return true;
      } else if (v1Parts[i] > v2Parts[i]) {
        return false;
      }
    }

    return v1Parts.length < v2Parts.length;
  }

  List<int> _parseVersion(String version) {
    return version.split('.').map((part) => int.tryParse(part) ?? 0).toList();
  }
}
