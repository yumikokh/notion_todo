import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../common/analytics/analytics_service.dart';
import '../repository/notion_oauth_repository.dart';

part 'notion_oauth_service.g.dart';

@Riverpod(keepAlive: true)
class NotionOAuthService extends _$NotionOAuthService {
  AnalyticsService get _analyticsService => ref.watch(analyticsServiceProvider);

  @override
  Future<String?> build() async {
    return await _initialize();
  }

  Future<String?> _initialize() async {
    final repository = await ref.read(notionOAuthRepositoryProvider.future);

    final isFirstLaunch = await repository.isFirstLaunch();
    final currentToken = await repository.loadAccessToken();

    // TODO: しばらく経ったら消す
    // 既存のトークンがある場合は、新しいオプションで書き換える
    if (currentToken != null) {
      await repository.saveAccessToken(currentToken);
    }

    // 初回起動時かつトークンが存在する場合のみ削除
    // これにより、正常なアプリの初回起動時にはトークンを削除せず
    // アプリの再インストール時のみトークンを削除する
    if (isFirstLaunch && currentToken != null) {
      await repository.deleteAccessToken();
      await repository.setIsFirstLaunch(false);

      try {
        await _analyticsService.logNotionAuth(
          action: 'reinstalled',
        );
      } catch (e) {
        print('Analytics error: $e');
      }

      return null;
    }

    // 初回起動だが、トークンが存在しない場合は、フラグのみ更新
    if (isFirstLaunch) {
      await repository.setIsFirstLaunch(false);
    }

    return currentToken;
  }

  Future<String?> authenticate() async {
    final repository = await ref.read(notionOAuthRepositoryProvider.future);

    final code = await repository.fetchAccessToken();
    if (code == null) return null;
    await repository.saveAccessToken(code);
    return code;
  }

  Future<void> deleteAccessToken() async {
    final repository = await ref.read(notionOAuthRepositoryProvider.future);
    await repository.deleteAccessToken();
  }
}
