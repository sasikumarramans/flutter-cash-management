// Import the envied configuration files for each flavor
import 'package:ev_flutter_app/env_demo.dart';
import 'package:ev_flutter_app/env_prod.dart';
import 'package:ev_flutter_app/env_staging.dart';

class EnvironmentConfig {
  static const String flavor =
      String.fromEnvironment('FLAVOR', defaultValue: 'prod');

  static String get quiltApiUrl {
    if (flavor == 'demo') return EnvDemo.apiUrl;
    if (flavor == 'staging') return EnvStaging.apiUrl;
    if (flavor == 'prod') return EnvProd.apiUrl;
    return '';
  }

  static String get quiltNotificationApiUrl {
    if (flavor == 'demo') return EnvDemo.notificationApiUrl;
    if (flavor == 'staging') return EnvStaging.notificationApiUrl;
    if (flavor == 'prod') return EnvProd.notificationApiUrl;
    return '';
  }

  static String get quiltApiKey {
    if (flavor == 'demo') return EnvDemo.apiKey;
    if (flavor == 'staging') return EnvStaging.apiKey;
    if (flavor == 'prod') return EnvProd.apiKey;
    return '';
  }

  static String get mqttBrokerUrl {
    if (flavor == 'demo') return EnvDemo.mqttBrokerUrl;
    if (flavor == 'staging') return EnvStaging.mqttBrokerUrl;
    if (flavor == 'prod') return EnvProd.mqttBrokerUrl;
    return '';
  }

  static String get mqttUsername {
    if (flavor == 'demo') return EnvDemo.mqttUsername;
    if (flavor == 'staging') return EnvStaging.mqttUsername;
    if (flavor == 'prod') return EnvProd.mqttUsername;
    return '';
  }

  static String get mqttPassword {
    if (flavor == 'demo') return EnvDemo.mqttPassword;
    if (flavor == 'staging') return EnvStaging.mqttPassword;
    if (flavor == 'prod') return EnvProd.mqttPassword;
    return '';
  }
}
