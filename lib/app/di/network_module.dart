import 'package:bearnshare/app/di/base/injectable_module.dart';
import 'package:bearnshare/app/environment.dart';
import 'package:bearnshare/data/network/core/dio_client.dart';
import 'package:bearnshare/data/network/core/dio_logging_interceptor.dart';
import 'package:bearnshare/data/network/core/header_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NetworkModule extends InjectableModule {
  @override
  Future<void> inject() async {
    safeRegisterSingleton<Dio>(() => _provideDio(EnvironmentConfig.apiUrl));
    safeRegisterSingleton<Dio>(
        () => _provideDio(EnvironmentConfig.apiUrl,
            contentType: 'multipart/form-data'),
        'multipart_dio');

    safeRegisterSingleton<Dio>(
        () => _provideDio(EnvironmentConfig.apiUrl), 'notification_dio');

    safeRegisterSingleton<DioClient>(() => DioClient());
    safeRegisterSingleton<DioClient>(
        () => DioClient('notification_dio'), 'notification_client');
    safeRegisterSingleton<DioClient>(
        () => DioClient('multipart_dio'), 'multipart_client');
  }

  Dio _provideDio(String baseUrl, {String? contentType}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: contentType ?? Headers.jsonContentType,
        connectTimeout: const Duration(
          seconds: 60,
        ),
      ),
    );

    dio.interceptors.add(HeaderInterceptor());
    if (kDebugMode) {
      dio.interceptors.add(
        DioLoggingInterceptor(),
      );
    }

    return dio;
  }

  @override
  void dispose() {
    safeUnregister<Dio>(scope: 'notification_dio');
    safeUnregister<Dio>(scope: 'multipart_dio');
    safeUnregister<DioClient>(scope: 'notification_client');
    safeUnregister<DioClient>(scope: 'multipart_client');
    safeUnregister<Dio>();
    safeUnregister<DioClient>();
  }
}
