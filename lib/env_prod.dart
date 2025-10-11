import 'package:envied/envied.dart';

part 'env_prod.g.dart';

@Envied(path: '.env.prod', obfuscate: true)
abstract class EnvProd {
  @EnviedField(varName: 'API_URL')
  static String apiUrl = _EnvProd.apiUrl;

  @EnviedField(varName: 'API_KEY')
  static String apiKey = _EnvProd.apiKey;
}
