// Import the envied configuration files for each flavor
import 'package:bearnshare/env_demo.dart';
import 'package:bearnshare/env_prod.dart';
import 'package:bearnshare/env_staging.dart';

class EnvironmentConfig {
  static const String flavor =
      String.fromEnvironment('FLAVOR', defaultValue: 'prod');

  static String get apiUrl {
    if (flavor == 'demo') return EnvDemo.apiUrl;
    if (flavor == 'staging') return EnvStaging.apiUrl;
    if (flavor == 'prod') return EnvProd.apiUrl;
    return '';
  }

  static String get apiKey {
    if (flavor == 'demo') return EnvDemo.apiKey;
    if (flavor == 'staging') return EnvStaging.apiKey;
    if (flavor == 'prod') return EnvProd.apiKey;
    return '';
  }
}
