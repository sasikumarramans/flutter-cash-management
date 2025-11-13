import 'package:bearnshare/data/network/core/dio_client.dart';
import 'package:bearnshare/domain/activity/activity_repository.dart';
import 'package:bearnshare/domain/activity/model/get_activities_request.dart';
import 'package:bearnshare/domain/activity/model/get_activities_response.dart';
import 'package:get_it/get_it.dart';

class ActivityApi extends ActivityRepository {
  final _dioClient = GetIt.I<DioClient>();
  static const String _getActivitiesPath = '/api/splits/activities';

  @override
  Future<ActivitiesResponse> getActivities(GetActivitiesRequest request) async {
    final response = await _dioClient.getRequest<ActivitiesResponse>(
      _getActivitiesPath,
      queryParameters: request.toJson(),
      parseDataJson: ActivitiesResponse.fromJson,
    );
    return response;
  }
}