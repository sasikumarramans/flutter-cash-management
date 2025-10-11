import 'package:envied/envied.dart';

part 'env_demo.g.dart';

@Envied(path: '.env.demo', obfuscate: true)
abstract class EnvDemo {
  @EnviedField(varName: 'API_URL')
  static String apiUrl = _EnvDemo.apiUrl;

  @EnviedField(varName: 'API_KEY')
  static String apiKey = _EnvDemo.apiKey;
}
