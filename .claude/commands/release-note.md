# ブランチの差分からAppleStoreとNotion用のリリースノートを自動作成する

## タスク

現在のブランチとoriginのmainブランチの差分を分析して、以下2種類のリリースノートを生成してください。

## 1. Apple Store用リリースノート

### 形式

- 「改善:」「新機能:」「バグ修正:」などのカテゴリで簡潔に記載（該当するものだけ）
- **以下の言語すべてで記載（各言語セクションを分けて）:**
  - 日本語
  - 英語 (English)
  - 韓国語 (한국어)
  - 中国語繁体字 (繁體中文)
  - スペイン語 (Español)
- ユーザー目線でわかりやすく
- 技術的な詳細は含めない
- 1行で簡潔に
- **コピー&ペースト用に、コードブロック内で「-」で始まる各行を独立させて出力（インデントなし）**

### 各言語のカテゴリ表記

- 日本語: 新機能 / 改善 / バグ修正
- English: New / Improvements / Bug Fixes
- 한국어: 신기능 / 개선 / 버그 수정
- 繁體中文: 新功能 / 改善 / 錯誤修正
- Español: Nuevo / Mejoras / Corrección de errores

### 例文

**日本語:**

```
- 新機能: 韓国語、中国語（繁体字）、スペイン語に対応しました
- 改善: タスク追加時に連続投稿できるようにするかを「設定 > 振る舞い」で切り替えられるようになりました
- バグ修正: 細かな不具合の修正とパフォーマンス改善を行いました
```

**English:**

```
- New: Added support for Korean, Traditional Chinese, and Spanish languages
- Improvements: You can now toggle continuous task addition in Settings > Behavior
- Bug Fixes: Fixed minor bugs and improved performance
```

## 2. Notion用リリースノート

### 形式

- 「✨ 新機能 / New Features」「📈 改善 / Improvements」「🐛 バグ修正 / Bug Fixes」のカテゴリで分類
- 日本語と英語の両方で記載（日本語が先、英語が後）
- より詳細な説明を含める
- ユーザー目線でわかりやすく

### 例文

```markdown
### ✨ 新機能 / New Features

- タスクを長押しして使える項目が増えました！これまでの「Notionで開く」機能の他、「Notionリンクをコピー」「タイトルをコピー」「タスクの複製」が追加されました。
More options are now available when long-pressing tasks! In addition to the existing "Open in Notion" feature, we've added "Copy Notion Link", "Copy Title", and "Duplicate Task".

### 📈 改善 / Improvements

- タスクリストやナビゲーションの余白を調整しました。
Better spacing for task lists and navigation.
- 一覧画面のプルで連携されたプロジェクトの内容も最新化できるようにしました。
Pull down to refresh linked projects in list view.

### 🐛 バグ修正 / Bug Fixes

- タスク完了音がバックグラウンドで再生中のBGMを停止してしまう問題を修正しました。
Task completion sounds no longer interrupt your background music.
```

## 実行手順

1. **バージョン情報の自動検出**:
   - `git diff origin/main...HEAD pubspec.yaml | grep version` で新旧バージョンを確認
   - バージョン番号を表示してユーザーに確認

2. **変更内容の分析**:
   - `git diff origin/main...HEAD` でブランチの差分を確認（origin/mainを使用）
   - `git log origin/main..HEAD --oneline` でコミットメッセージを取得
   - コミットメッセージのプレフィックス（feat:, fix:, chore:など）から自動カテゴリ分類
   - 変更されたファイルとコードの変更内容を分析

3. **ユーザー影響の抽出**:
   - ユーザーに影響する変更を抽出（内部実装の変更は除外）
   - 機能追加、改善、バグ修正に分類

4. **提案とフィードバック**:
   - **一度提案内容を提示してユーザーの確認とフィードバックを受ける**
   - ユーザーが修正を指示した場合は、その内容を反映して再提示

5. **最終出力**:
   - Apple Store用: 全5言語分のリリースノートを生成
   - Notion用: 日本語と英語のリリースノートを生成

6. **Notion連携（オプション）**:
   - 最終確認が取れたら：
     - Notion APIが利用可能な場合は、MCP経由で[Notionのリリースノート](https://www.notion.so/yumikokh/Release-Notes-18154c37a54c807b8ac6ef6612524378?source=copy_link)に反映
     - Notion APIが利用できない場合は、手動コピー用のマークダウンを提供

## 注意事項

- ユーザーが理解しやすい言葉を使用
- 機能の利点を明確に伝える
- 各言語で同じ内容を正確に伝える（翻訳の一貫性を保つ）
- Notion用は詳細に、Apple Store用は簡潔に
- 技術的な内部実装の変更（リファクタリング、lintルール更新、ライブラリ更新、テストの追加など）は含めない
- ユーザーに見える変更のみを記載する

## コミットプレフィックスの解釈

- `feat:` → 新機能
- `fix:` → バグ修正
- `improve:` / `perf:` → 改善
- `chore:` / `docs:` / `test:` / `refactor:` → 通常は除外（ユーザー影響がある場合のみ含める）
