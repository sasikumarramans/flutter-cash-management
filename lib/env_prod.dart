import 'package:envied/envied.dart';

part 'env_prod.g.dart';

@Envied(path: '.env.prod')
abstract class EnvProd {
  @EnviedField(varName: 'API_URL', obfuscate: true)
  static String apiUrl = _EnvProd.apiUrl;

  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static String apiKey = _EnvProd.apiKey;

  @EnviedField(varName: 'NOTIFICATION_API_URL', obfuscate: true)
  static String notificationApiUrl = _EnvProd.notificationApiUrl;

  @EnviedField(varName: 'MQTT_BROKER_URL', obfuscate: true)
  static String mqttBrokerUrl = _EnvProd.mqttBrokerUrl;

  @EnviedField(varName: 'MQTT_USERNAME', obfuscate: true)
  static String mqttUsername = _EnvProd.mqttUsername;

  @EnviedField(varName: 'MQTT_PASSWORD', obfuscate: true)
  static String mqttPassword = _EnvProd.mqttPassword;
}
