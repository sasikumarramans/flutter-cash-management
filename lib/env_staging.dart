import 'package:envied/envied.dart';

part 'env_staging.g.dart';

@Envied(path: '.env.staging', obfuscate: true)
abstract class EnvStaging {
  @EnviedField(varName: 'API_URL')
  static String apiUrl = _EnvStaging.apiUrl;

  @EnviedField(varName: 'API_KEY')
  static String apiKey = _EnvStaging.apiKey;
}
