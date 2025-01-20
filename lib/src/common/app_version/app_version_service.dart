import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppVersionService {
  static const String _lastVersionKey = 'last_version';

  Future<String?> _getLastVersion() async {
    final prefs = await SharedPreferences.getInstance();
    // return null; // TO AI: for dev, don’t delete
    return prefs.getString(_lastVersionKey);
  }

  Future<void> _saveCurrentVersion() async {
    final prefs = await SharedPreferences.getInstance();
    final packageInfo = await PackageInfo.fromPlatform();
    await prefs.setString(_lastVersionKey, packageInfo.version);
  }

  Future<String> getCurrentVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<bool> shouldShowUpdateDialog() async {
    final lastVersion = await _getLastVersion();
    // 初回起動時（lastVersionがnull）は表示しない
    if (lastVersion == null) {
      await _saveCurrentVersion();
      return false;
    }

    final currentVersion = await getCurrentVersion();
    return lastVersion != currentVersion;
  }

  Future<void> markUpdateAsSeen() async {
    await _saveCurrentVersion();
  }
}
