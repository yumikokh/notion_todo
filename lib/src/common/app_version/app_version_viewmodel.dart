import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_version_service.dart';

part 'app_version_viewmodel.g.dart';

@riverpod
AppVersionViewModel appVersionViewModel(ref) {
  return AppVersionViewModel(AppVersionService());
}

class AppVersionViewModel {
  final AppVersionService _service;

  AppVersionViewModel(this._service);

  Future<bool> shouldShowUpdateDialog() async {
    return _service.shouldShowUpdateDialog();
  }

  Future<String> getCurrentVersion() async {
    return _service.getCurrentVersion();
  }

  Future<void> markUpdateAsSeen() async {
    await _service.saveCurrentVersion();
  }
}
