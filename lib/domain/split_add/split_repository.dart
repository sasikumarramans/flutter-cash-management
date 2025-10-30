import 'package:bearnshare/domain/split_add/model/add_split_request.dart';
import 'package:bearnshare/domain/split_add/model/add_split_response.dart';

abstract class SplitRepository {
  Future<AddSplitResponse> addSplit(AddSplitRequest request);
}