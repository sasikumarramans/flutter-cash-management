import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsManager {
  Future<PermissionStatus> getLocationPermissionStatus() async {
    PermissionStatus permissionStatus = await Permission.location.status;
    return permissionStatus;
  }

  Future<PermissionStatus> requestLocationPermission() async {
    PermissionStatus permissionStatus = await Permission.location.request();
    return permissionStatus;
  }

  Future<bool> requestNotificationPermission() async {
    PermissionStatus askNotification = await Permission.notification.request();
    if (askNotification.isGranted) {
      return true;
    }
    return false;
  }

  Future<PermissionStatus> requestCameraPermission() async {
    PermissionStatus permissionStatus = await requestCameraPermissionStatus();
    if (permissionStatus.isGranted || permissionStatus.isLimited) {
      return permissionStatus;
    }
    PermissionStatus askNotification = await Permission.camera.request();
    return askNotification;
  }

  Future<PermissionStatus> requestCameraPermissionStatus() async {
    PermissionStatus askNotification = await Permission.camera.status;
    return askNotification;
  }

  Future<PermissionStatus> requestGalleryPermissionStatus() async {
    PermissionStatus askNotification;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        askNotification = await Permission.storage.status;
      } else {
        askNotification = await Permission.photos.status;
      }
    } else {
      askNotification = await Permission.photos.status;
    }
    return askNotification;
  }

  Future<PermissionStatus> requestGalleryPermission() async {
    PermissionStatus permissionStatus = await requestGalleryPermissionStatus();
    if (permissionStatus.isLimited || permissionStatus.isGranted) {
      return permissionStatus;
    }
    PermissionStatus askNotification;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        askNotification = await Permission.storage.request();
      } else {
        askNotification = await Permission.photos.request();
      }
    } else {
      askNotification = await Permission.photos.request();
    }
    return askNotification;
  }

  Future<PermissionStatus> requestFilesPermissionStatus() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        return await Permission.storage.status;
      } else {
        return await Permission.manageExternalStorage.status;
      }
    } else {
      return PermissionStatus.granted;
    }
  }

  Future<PermissionStatus> requestFilesPermission() async {
    final permissionStatus = await requestFilesPermissionStatus();
    if (permissionStatus.isGranted || permissionStatus.isLimited) {
      return permissionStatus;
    }
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        return await Permission.storage.request();
      } else {
        return await Permission.manageExternalStorage.request();
      }
    } else {
      return PermissionStatus.granted;
    }
  }

  void openSettings() {
    openAppSettings();
  }
}
