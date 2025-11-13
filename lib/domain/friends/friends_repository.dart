import 'package:bearnshare/domain/friends/model/get_friends_request.dart';
import 'package:bearnshare/domain/friends/model/get_friends_response.dart';

abstract class FriendsRepository {
  Future<FriendsResponse> getFriends(GetFriendsRequest request);
}