// Temporarily disable envied for Flutter version update
// import 'package:envied/envied.dart';

// part 'env.g.dart';

// @Envied(path: '.env')
abstract class Env {
  // Temporary hardcoded values for Flutter version update
  // Replace with proper envied configuration after update
  static const String oAuthClientId = 'dummy_oauth_client_id';
  static const String oAuthClientSecret = 'dummy_oauth_client_secret';
  static const String notionAuthUrl = 'https://api.notion.com/v1/oauth/authorize';
  static const String redirectUri = 'https://dummy.example.com/callback';
  static const String sentryDsn = 'https://dummy@sentry.io/project';
  static const String revenueCatApiKey = 'dummy_revenue_cat_api_key';
}
