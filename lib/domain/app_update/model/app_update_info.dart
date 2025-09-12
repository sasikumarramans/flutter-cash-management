class AppUpdateModel {
  final String currentVersion;
  final String minRequiredVersion;
  final String latestVersion;
  final String androidUpdateUrl;
  final String iosUpdateUrl;
  final String updateMessage;
  final bool isUpdateRequired;
  final bool isUpdateAvailable;

  AppUpdateModel({
    required this.currentVersion,
    required this.minRequiredVersion,
    required this.latestVersion,
    required this.androidUpdateUrl,
    required this.iosUpdateUrl,
    required this.updateMessage,
    required this.isUpdateRequired,
    required this.isUpdateAvailable,
  });
}
