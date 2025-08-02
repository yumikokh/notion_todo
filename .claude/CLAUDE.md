# Claude Code Instructions

## プロジェクト概要

**Tanzaku Todo** - Notion APIをバックエンドとするFlutterタスクマネージャーアプリ

### アーキテクチャ

- **状態管理**: Riverpod 2.6.1（コード生成対応）
- **パターン**: Repository + ViewModel
- **データモデル**: Freezed + json_annotation
- **プラットフォーム**: 今のところiOS特化（ウィジェット・バックグラウンド処理対応）

## プロジェクト構造

```text
lib/src/
├── app.dart (メインアプリ設定)
├── common/ (共通コンポーネント - Analytics, UI, Sound)
├── notion/ (Notion API統合 - API, Model, OAuth, Tasks)
├── settings/ (設定機能 - Font, Theme, Database)
└── subscription/ (RevenueCat統合)
```

## 主要機能

- **Notion統合**: OAuth認証、データベース選択、リアルタイム同期
- **タスク管理**: CRUD操作、フィルタリング、優先度設定
- **iOS専用**: 5種類ウィジェット（ホーム/ロック画面）、バックグラウンド更新
- **UI/UX**: Material Design 3、ダークモード、多言語対応

## 開発ルール

- 日本語でコメント・応答
- 新しいコードには必ずテスト作成
- Flutterコーディング規約準拠
- iOS Human Interface Guidelines準拠

## よく使うコマンド

- `flutter clean` - ビルドキャッシュクリア
- `flutter build ios` - iOSビルド
- `flutter run` - デバッグ実行
- `flutter test` - テスト実行
- `flutter analyze` - コード解析
- `flutter gen-l10n` - 多言語化ファイル生成
- `dart run build_runner build` - コード生成

## 重要な技術スタック

- **UI**: Material Design 3, Google Fonts
- **状態管理**: Riverpod + hooks_riverpod
- **API**: Notion API (OAuth), dio
- **iOS**: WidgetKit (SwiftUI), App Groups
- **監視**: Firebase Analytics, Sentry
- **課金**: RevenueCat (purchases_flutter)

## 設計方針

- iOSエコシステム深度統合
- 型安全性重視（Freezed活用）
- テスタビリティ確保（Repository分離）
- パフォーマンス最適化（ウィジェット・バックグラウンド）

## GitHub Actions

- `@claude`でコメントするとClaude Codeが起動
- PRやイシューで日本語サポート
- Flutter専用ツール許可済み
