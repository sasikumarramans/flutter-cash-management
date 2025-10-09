import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class CustomImageCacheManager extends CacheManager with ImageCacheManager {
  static const key = 'appImageCaches';

  static CustomImageCacheManager? _instance;

  factory CustomImageCacheManager() {
    _instance ??= CustomImageCacheManager._();
    return _instance!;
  }

  CustomImageCacheManager._()
      : super(Config(
          key,
          stalePeriod: const Duration(days: 7),
          maxNrOfCacheObjects: 20,
          repo: JsonCacheInfoRepository(databaseName: key),
          fileSystem: IOFileSystem(key),
          fileService: HttpFileService(),
        ));

  Future<String> getFilePath() async {
    final directory = await getTemporaryDirectory();
    return p.join(directory.path, key);
  }
}
