import 'package:bearnshare/data/network/core/dio_client.dart';
import 'package:bearnshare/domain/auth/login/model/user_response_object.dart';
import 'package:bearnshare/domain/profile/model/unique_user_name_request.dart';
import 'package:bearnshare/domain/profile/model/unique_user_name_response.dart';
import 'package:bearnshare/domain/profile/model/user_data_object.dart';
import 'package:bearnshare/domain/profile/profile_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class ProfileApi extends ProfileRepository {
  final _dioClient = GetIt.I<DioClient>();
  static const String _isUniqueUsernamePath = '/api/user/check-username';
  static const String updateUser = '/api/user/profile';

  @override
  Future<UniqueUserNameResponse> isUniqueUsername(UniqueUserNameRequest request,
      {CancelToken? cancelToken}) {
    return _dioClient.getRequest<UniqueUserNameResponse>(
      _isUniqueUsernamePath,
      queryParameters: request.toJson(),
      parseDataJson: UniqueUserNameResponse.fromJson,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<UserResponseObject> updateProfileApi(request) async {
    final updateUserResponse = await _dioClient.putRequest<UserResponseObject>(
      updateUser,
      data: request,
      parseDataJson: UserResponseObject.fromJson,
    );

    return updateUserResponse;
  }

  @override
  Future<UserDataObject> getProfileApi() async {
    final getUserResponse = await _dioClient.getRequest<UserDataObject>(
      updateUser,
      parseDataJson: UserDataObject.fromJson,
    );
    return getUserResponse;
  }
}
