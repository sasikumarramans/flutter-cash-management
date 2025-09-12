import 'package:ev_flutter_app/app/di/base/injectable_module.dart';
import 'package:ev_flutter_app/app/helpers/app_file_manager.dart';
import 'package:ev_flutter_app/app/helpers/file_manager.dart';
import 'package:ev_flutter_app/data/local/hive_manager.dart';
import 'package:ev_flutter_app/data/local/session.dart';
import 'package:ev_flutter_app/data/local/shared_preferences_repository.dart';
import 'package:ev_flutter_app/presentation/component/cache_manager/drafts_cache_manager.dart';
import 'package:ev_flutter_app/presentation/component/cache_manager/profile_cache_manager.dart';
import 'package:ev_flutter_app/presentation/component/cache_manager/ugc_image_cache_manager.dart';
import 'package:ev_flutter_app/presentation/component/media_picker_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataModule extends InjectableModule {
  @override
  Future<void> inject() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    safeRegisterSingleton<SharedPreferences>(() => sharedPreferences);

    safeRegisterSingleton<SharedPreferencesRepository>(
        () => SharedPreferencesRepository());
    safeRegisterSingleton<Session>(() => Session());

    HiveManager hiveManager = HiveManager();
    await hiveManager.initHive();

    safeRegisterSingleton<HiveManager>(() => hiveManager);
    safeRegisterSingleton<ProfileCacheManager>(() => ProfileCacheManager());
    safeRegisterLazySingleton<DraftsCacheManager>(() => DraftsCacheManager());
  }

  @override
  Future<void> lateInject() async {
    safeRegisterLazySingleton<UGCImageCacheManager>(
        () => UGCImageCacheManager());

    safeRegisterLazySingleton<MediaPickerManager>(() => MediaPickerManager());
    safeRegisterLazySingleton<FileManager>(() => FileManager());
    safeRegisterLazySingleton<AppFileManager>(() => AppFileManager());
  }

  @override
  void dispose() {
    safeUnregister<Session>();
    safeUnregister<SharedPreferencesRepository>();
    safeUnregister<SharedPreferences>();
    safeUnregister<HiveManager>();
    safeUnregister<DraftsCacheManager>();
    safeUnregister<UGCImageCacheManager>();
    safeUnregister<ProfileCacheManager>();
    safeUnregister<MediaPickerManager>();
  }
}
