import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:bearnshare/domain/friends/friends_repository.dart';
import 'package:bearnshare/domain/friends/model/get_friends_request.dart';
import 'package:bearnshare/domain/friends/model/get_friends_response.dart';
import 'package:get_it/get_it.dart';

class GetFriendsUseCase extends BaseUseCase<GetFriendsRequest, FriendsResponse> {
  final _friendsRepository = GetIt.I.get<FriendsRepository>();

  @override
  Future<FriendsResponse> execute({GetFriendsRequest? request}) async {
    return await _friendsRepository.getFriends(request!);
  }
}