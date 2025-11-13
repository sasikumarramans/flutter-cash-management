import 'package:bearnshare/data/network/core/dio_client.dart';
import 'package:bearnshare/domain/split_add/model/add_split_request.dart';
import 'package:bearnshare/domain/split_add/model/add_split_response.dart';
import 'package:bearnshare/domain/split_add/model/get_splits_request.dart';
import 'package:bearnshare/domain/split_add/model/get_splits_response.dart';
import 'package:bearnshare/domain/split_add/split_repository.dart';
import 'package:get_it/get_it.dart';

class SplitApi extends SplitRepository {
  final _dioClient = GetIt.I<DioClient>();
  static const String _addSplitPath = '/api/splits';
  static const String _getSplitsPath = '/api/splits/groups';

  @override
  Future<AddSplitResponse> addSplit(AddSplitRequest request) async {
    final response = await _dioClient.postRequest<AddSplitResponse>(
      _addSplitPath,
      data: request.toJson(),
      parseDataJson: AddSplitResponse.fromJson,
    );
    return response;
  }

  @override
  Future<GetSplitsResponse> getSplits(GetSplitsRequest request) async {
    final response = await _dioClient.getRequest<GetSplitsResponse>(
      '$_getSplitsPath/${request.groupId}',
      queryParameters: request.toJson(),
      parseDataJson: GetSplitsResponse.fromJson,
    );
    return response;
  }
}