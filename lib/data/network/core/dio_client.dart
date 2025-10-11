import 'dart:core';

import 'package:dio/dio.dart';
import 'package:ev_flutter_app/app/router/router_manager.dart';
import 'package:ev_flutter_app/data/local/hive_manager.dart';
import 'package:ev_flutter_app/data/network/core/api_exception.dart';
import 'package:ev_flutter_app/data/network/core/base_response.dart';
import 'package:ev_flutter_app/presentation/main_router.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class DioClient {
  Dio _dio = GetIt.I.get<Dio>();
  DioClient([String? instanceName]) {
    _dio = GetIt.I.get<Dio>(instanceName: instanceName);
  }
  Future<T> postRequest<T>(String path,
      {required dynamic data,
      Map<String, dynamic>? queryParameters,
      T Function(Map<String, dynamic>)? parseDataJson,
      T Function(List<dynamic>)? parseListDataJson,
      bool? sendCompleteResponse}) {
    return _handleRequest(() async {
      return _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    },
        parseDataJson: parseDataJson,
        parseListDataJson: parseListDataJson,
        sendCompleteResponse: sendCompleteResponse);
  }

  Future<Uint8List> downloadImage(String imageUrl) async {
    final Dio dio = Dio();
    try {
      final response = await dio.get<List<int>>(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200 && response.data != null) {
        return Uint8List.fromList(response.data!);
      } else {
        throw ApiException(
          message:
              "Failed to download image. Status code: ${response.statusCode}",
        );
      }
    } on Exception catch (error) {
      throw ApiException(message: "Unexpected error occurred: $error");
    } finally {
      dio.close();
    }
  }

  Future<T> getRequest<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? parseDataJson,
    T Function(List<dynamic>)? parseListDataJson,
    CancelToken? cancelToken,
    bool? sendCompleteResponse,
  }) {
    return _handleRequest(() {
      return _dio.get(path,
          queryParameters: queryParameters, cancelToken: cancelToken);
    },
        parseDataJson: parseDataJson,
        parseListDataJson: parseListDataJson,
        sendCompleteResponse: sendCompleteResponse);
  }

  Future<T> putRequest<T>(String path,
      {required dynamic data,
      Map<String, dynamic>? queryParameters,
      T Function(Map<String, dynamic>)? parseDataJson,
      T Function(List<dynamic>)? parseListDataJson}) {
    return _handleRequest(
      () async {
        return _dio.put(path, data: data, queryParameters: queryParameters);
      },
      parseDataJson: parseDataJson,
      parseListDataJson: parseListDataJson,
    );
  }

  Future<T> deleteRequest<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? parseDataJson,
    T Function(List<dynamic>)? parseListDataJson,
  }) {
    return _handleRequest(
      () {
        return _dio.delete(path, queryParameters: queryParameters);
      },
      parseDataJson: parseDataJson,
      parseListDataJson: parseListDataJson,
    );
  }

  Future<T> _handleRequest<T>(
    Future<Response> Function() request, {
    T Function(Map<String, dynamic>)? parseDataJson,
    T Function(List<dynamic>)? parseListDataJson,
    bool? sendCompleteResponse,
  }) async {
    try {
      final Response response = await request();
      final responseBody = BaseResponse<T>.fromJson(response.data,
          parseDataJson: parseDataJson,
          parseDataJsonList: parseListDataJson,
          sendCompleteResponse: sendCompleteResponse);
      if (kDebugMode) {
        debugPrint(responseBody.isSuccessful.toString());
        debugPrint(responseBody.data.toString());
      }
      print("object1234");
      if (responseBody.isSuccessful && responseBody.data != null) {
        return responseBody.data!;
      } else {
        throw ApiException(
          message: responseBody.errorMsg,
          errorCode: responseBody.errorCode,
        );
      }
    } on DioException catch (e) {
      _throwIfKnownError(e);
      throw const ApiException(message: 'An unknown error occurred');
    }
  }

  Future<void> handleUnauthorizedError() async {
    final router = GetIt.I.get<RouterManager>();
    await GetIt.I<HiveManager>().clearHive();
    router.goRouter.go(MainRouter.mainScreenRoute);
  }

  void _throwIfKnownError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw const ApiException(message: 'Connection timeout occurred');
      case DioExceptionType.sendTimeout:
        throw const ApiException(message: 'Send timeout occurred');
      case DioExceptionType.receiveTimeout:
        throw const ApiException(message: 'Receive timeout occurred');
      case DioExceptionType.badCertificate:
        throw const ApiException(message: 'Bad certificate error');
      case DioExceptionType.badResponse:
        _handleBadResponse(e.response);
        break;
      case DioExceptionType.cancel:
        throw const ApiException(message: 'Request was cancelled');
      case DioExceptionType.connectionError:
        throw const ApiException(message: 'Connection error occurred');
      case DioExceptionType.unknown:
        throw const ApiException(message: 'An unknown error occurred');
    }
  }

  void _handleBadResponse(Response<dynamic>? response) {
    if (response != null) {
      // Check if response body contains error message
      if (response.data is Map && response.data['error'] != null) {
        throw ApiException(
          message: response.data['error'],
          errorCode: response.statusCode,
        );
      }

      switch (response.statusCode) {
        case 401:
        case 402:
        case 403:
          handleUnauthorizedError();
        case 405:
          throw const ModerationException();
        case 500:
          throw const BadResponseException();

        default:
          throw ApiException(
              message: 'Received invalid status code: ${response.statusCode}');
      }
    } else {
      throw const ApiException(message: 'Bad response without status code');
    }
  }
}
