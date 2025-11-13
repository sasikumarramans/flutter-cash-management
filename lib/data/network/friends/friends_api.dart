import 'package:bearnshare/data/network/core/dio_client.dart';
import 'package:bearnshare/domain/friends/friends_repository.dart';
import 'package:bearnshare/domain/friends/model/get_friends_request.dart';
import 'package:bearnshare/domain/friends/model/get_friends_response.dart';
import 'package:get_it/get_it.dart';

class FriendsApi extends FriendsRepository {
  final _dioClient = GetIt.I<DioClient>();
  static const String _getFriendsPath = '/api/friends';

  @override
  Future<FriendsResponse> getFriends(GetFriendsRequest request) async {
    final response = await _dioClient.getRequest<FriendsResponse>(
      _getFriendsPath,
      queryParameters: request.toJson(),
      parseDataJson: FriendsResponse.fromJson,
    );
    return response;
  }
}