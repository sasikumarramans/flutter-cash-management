import 'package:bearnshare/data/local/shared_preferences_repository.dart';
import 'package:get_it/get_it.dart';

class Session {
  final _sharedPreferencesRepository = GetIt.I<SharedPreferencesRepository>();

  Future<void> setLanguage(String language) async {
    await _sharedPreferencesRepository.setString(
      language,
      SharedPreferencesRepository.languageKey,
    );
  }

  String getLanguage() {
    return _sharedPreferencesRepository.getString(
      SharedPreferencesRepository.languageKey,
    );
  }
}
