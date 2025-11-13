import 'package:bearnshare/data/network/core/dio_client.dart';
import 'package:bearnshare/domain/group/group_repository.dart';
import 'package:bearnshare/domain/group/model/create_group_request.dart';
import 'package:bearnshare/domain/group/model/create_group_response.dart';
import 'package:bearnshare/domain/group/model/get_groups_request.dart';
import 'package:bearnshare/domain/group/model/get_groups_response.dart';
import 'package:bearnshare/domain/group/model/search_user_request.dart';
import 'package:bearnshare/domain/group/model/search_user_response.dart';
import 'package:bearnshare/domain/split_add/model/search_request.dart';
import 'package:bearnshare/domain/split_add/model/search_response.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class GroupApi extends GroupRepository {
  final _dioClient = GetIt.I<DioClient>();
  static const String _createGroupPath = '/api/groups';
  static const String _searchUserPath = '/api/user/search';
  static const String _getGroupsPath = '/api/groups';
  static const String _searchPath = '/api/search';

  @override
  Future<CreateGroupResponse> createGroup(CreateGroupRequest request) async {
    final response = await _dioClient.postRequest<CreateGroupResponse>(
      _createGroupPath,
      data: request.toJson(),
      parseDataJson: CreateGroupResponse.fromJson,
    );
    return response;
  }

  @override
  Future<SearchUserResponse> searchUsers(SearchUserRequest request,
      {CancelToken? cancelToken}) async {
    final response = await _dioClient.getRequest<SearchUserResponse>(
      _searchUserPath,
      queryParameters: request.toJson(),
      parseListDataJson: SearchUserResponse.fromJsonList,
      cancelToken: cancelToken,
    );
    return response;
  }

  @override
  Future<GroupsResponse> getGroups(GetGroupsRequest request) async {
    final response = await _dioClient.getRequest<GroupsResponse>(
      _getGroupsPath,
      queryParameters: request.toJson(),
      parseDataJson: GroupsResponse.fromJson,
    );
    return response;
  }

  @override
  Future<SearchResponse> search(SearchRequest request,
      {CancelToken? cancelToken}) async {
    final response = await _dioClient.getRequest<SearchResponse>(
      _searchPath,
      queryParameters: request.toJson(),
      parseDataJson: SearchResponse.fromJson,
      cancelToken: cancelToken,
    );
    return response;
  }
}
