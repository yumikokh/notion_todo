import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'OAUTH_CLIENT_ID')
  static const String oAuthClientId = _Env.oAuthClientId;

  @EnviedField(varName: 'OAUTH_CLIENT_SECRET')
  static const String oAuthClientSecret = _Env.oAuthClientSecret;

  @EnviedField(varName: 'NOTION_AUTH_URL')
  static const String notionAuthUrl = _Env.notionAuthUrl;

  @EnviedField(varName: 'REDIRECT_URI')
  static const String redirectUri = _Env.redirectUri;

  @EnviedField(varName: 'SENTRY_DSN')
  static const String sentryDsn = _Env.sentryDsn;
}
