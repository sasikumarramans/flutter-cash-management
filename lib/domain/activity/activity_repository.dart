import 'package:bearnshare/domain/activity/model/get_activities_request.dart';
import 'package:bearnshare/domain/activity/model/get_activities_response.dart';

abstract class ActivityRepository {
  Future<ActivitiesResponse> getActivities(GetActivitiesRequest request);
}