import 'package:bearnshare/app/environment.dart';
import 'package:bearnshare/app/helpers/extensions/string_extensions.dart';
import 'package:bearnshare/data/local/hive_manager.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class HeaderInterceptor extends Interceptor {
  final String _apiKey = EnvironmentConfig.apiKey;
  final HiveManager _hiveManager = GetIt.I<HiveManager>();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? userToken =
        _hiveManager.getFromHive(HiveManager.userSessionTokenKey);

    final authToken = userToken.isNullOrEmpty ? _apiKey : userToken;
    options.headers['Authorization'] = 'Bearer $authToken';

    super.onRequest(options, handler);
  }
}
