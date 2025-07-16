import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../settings/settings_service.dart';
import 'toggl_api_service.dart';

part 'toggl_viewmodel.g.dart';
part 'toggl_viewmodel.freezed.dart';

@freezed
class TogglState with _$TogglState {
  const factory TogglState({
    @Default(false) bool isConfigured,
    @Default(false) bool isLoading,
    @Default([]) List<TogglWorkspace> workspaces,
    @Default([]) List<TogglProject> projects,
    TogglTimeEntry? currentTimeEntry,
    String? error,
    String? apiToken,
    int? workspaceId,
    int? projectId,
    @Default(false) bool enabled,
  }) = _TogglState;
}

@riverpod
class TogglViewModel extends _$TogglViewModel {
  late final SettingsService _settingsService;

  @override
  Future<TogglState> build() async {
    _settingsService = SettingsService();
    return await _loadSettings();
  }

  Future<TogglState> _loadSettings() async {
    final apiToken = await _settingsService.loadTogglApiToken();
    final workspaceId = await _settingsService.loadTogglWorkspaceId();
    final projectId = await _settingsService.loadTogglProjectId();
    final enabled = await _settingsService.loadTogglEnabled();
    final isConfigured = await _settingsService.isTogglConfigured();

    return TogglState(
      apiToken: apiToken,
      workspaceId: workspaceId,
      projectId: projectId,
      enabled: enabled,
      isConfigured: isConfigured,
    );
  }

  /// APIトークンを保存
  Future<void> saveApiToken(String token) async {
    state = const AsyncValue.loading();
    
    try {
      await _settingsService.saveTogglApiToken(token);
      final newState = await _loadSettings();
      state = AsyncValue.data(newState);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// ワークスペースIDを保存
  Future<void> saveWorkspaceId(int workspaceId) async {
    state = const AsyncValue.loading();
    
    try {
      await _settingsService.saveTogglWorkspaceId(workspaceId);
      final newState = await _loadSettings();
      state = AsyncValue.data(newState);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// プロジェクトIDを保存
  Future<void> saveProjectId(int? projectId) async {
    state = const AsyncValue.loading();
    
    try {
      await _settingsService.saveTogglProjectId(projectId);
      final newState = await _loadSettings();
      state = AsyncValue.data(newState);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Toggl連携の有効/無効を切り替え
  Future<void> setEnabled(bool enabled) async {
    state = const AsyncValue.loading();
    
    try {
      await _settingsService.saveTogglEnabled(enabled);
      final newState = await _loadSettings();
      state = AsyncValue.data(newState);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// ワークスペース一覧を取得
  Future<void> loadWorkspaces() async {
    final currentState = state.valueOrNull;
    if (currentState?.apiToken == null) return;

    state = AsyncValue.data(currentState!.copyWith(isLoading: true));

    try {
      final apiService = TogglApiService(
        apiToken: currentState.apiToken!,
        workspaceId: 0, // ワークスペース取得時はworkspaceId不要
      );

      final workspaces = await apiService.getWorkspaces();
      state = AsyncValue.data(currentState.copyWith(
        workspaces: workspaces,
        isLoading: false,
        error: null,
      ));
    } catch (e) {
      state = AsyncValue.data(currentState.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  /// プロジェクト一覧を取得
  Future<void> loadProjects() async {
    final currentState = state.valueOrNull;
    if (currentState?.apiToken == null || currentState?.workspaceId == null) return;

    state = AsyncValue.data(currentState!.copyWith(isLoading: true));

    try {
      final apiService = TogglApiService(
        apiToken: currentState.apiToken!,
        workspaceId: currentState.workspaceId!,
      );

      final projects = await apiService.getProjects();
      state = AsyncValue.data(currentState.copyWith(
        projects: projects,
        isLoading: false,
        error: null,
      ));
    } catch (e) {
      state = AsyncValue.data(currentState.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  /// タイムエントリーを開始
  Future<void> startTimeEntry(String description, {List<String>? tags}) async {
    final currentState = state.valueOrNull;
    if (!_canUseTogglApi(currentState)) return;

    state = AsyncValue.data(currentState!.copyWith(isLoading: true));

    try {
      final apiService = TogglApiService(
        apiToken: currentState.apiToken!,
        workspaceId: currentState.workspaceId!,
      );

      final timeEntry = await apiService.startTimeEntry(
        description: description,
        projectId: currentState.projectId,
        tags: tags,
      );

      state = AsyncValue.data(currentState.copyWith(
        currentTimeEntry: timeEntry,
        isLoading: false,
        error: null,
      ));
    } catch (e) {
      state = AsyncValue.data(currentState.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  /// 現在のタイムエントリーを取得
  Future<void> getCurrentTimeEntry() async {
    final currentState = state.valueOrNull;
    if (!_canUseTogglApi(currentState)) return;

    try {
      final apiService = TogglApiService(
        apiToken: currentState!.apiToken!,
        workspaceId: currentState.workspaceId!,
      );

      final timeEntry = await apiService.getCurrentTimeEntry();
      state = AsyncValue.data(currentState.copyWith(
        currentTimeEntry: timeEntry,
        error: null,
      ));
    } catch (e) {
      state = AsyncValue.data(currentState.copyWith(
        error: e.toString(),
      ));
    }
  }

  /// タイムエントリーを停止
  Future<void> stopCurrentTimeEntry() async {
    final currentState = state.valueOrNull;
    if (!_canUseTogglApi(currentState) || currentState!.currentTimeEntry == null) return;

    state = AsyncValue.data(currentState.copyWith(isLoading: true));

    try {
      final apiService = TogglApiService(
        apiToken: currentState.apiToken!,
        workspaceId: currentState.workspaceId!,
      );

      await apiService.stopTimeEntry(currentState.currentTimeEntry!.id);
      state = AsyncValue.data(currentState.copyWith(
        currentTimeEntry: null,
        isLoading: false,
        error: null,
      ));
    } catch (e) {
      state = AsyncValue.data(currentState.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  bool _canUseTogglApi(TogglState? state) {
    return state != null &&
        state.isConfigured &&
        state.enabled &&
        state.apiToken != null &&
        state.workspaceId != null;
  }
}