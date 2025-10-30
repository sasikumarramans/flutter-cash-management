import 'package:bearnshare/data/network/core/dio_client.dart';
import 'package:bearnshare/domain/split_add/model/add_split_request.dart';
import 'package:bearnshare/domain/split_add/model/add_split_response.dart';
import 'package:bearnshare/domain/split_add/split_repository.dart';
import 'package:get_it/get_it.dart';

class SplitApi extends SplitRepository {
  final _dioClient = GetIt.I<DioClient>();
  static const String _addSplitPath = '/api/splits';

  @override
  Future<AddSplitResponse> addSplit(AddSplitRequest request) async {
    final response = await _dioClient.postRequest<AddSplitResponse>(
      _addSplitPath,
      data: request.toJson(),
      parseDataJson: AddSplitResponse.fromJson,
    );
    return response;
  }
}