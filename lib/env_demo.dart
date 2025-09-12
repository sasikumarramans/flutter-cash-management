import 'package:envied/envied.dart';

part 'env_demo.g.dart';

@Envied(path: '.env.demo')
abstract class EnvDemo {
  @EnviedField(varName: 'API_URL', obfuscate: true)
  static String apiUrl = _EnvDemo.apiUrl;

  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static String apiKey = _EnvDemo.apiKey;

  @EnviedField(varName: 'NOTIFICATION_API_URL', obfuscate: true)
  static String notificationApiUrl = _EnvDemo.notificationApiUrl;

  @EnviedField(varName: 'MQTT_BROKER_URL', obfuscate: true)
  static String mqttBrokerUrl = _EnvDemo.mqttBrokerUrl;

  @EnviedField(varName: 'MQTT_USERNAME', obfuscate: true)
  static String mqttUsername = _EnvDemo.mqttUsername;

  @EnviedField(varName: 'MQTT_PASSWORD', obfuscate: true)
  static String mqttPassword = _EnvDemo.mqttPassword;
}
