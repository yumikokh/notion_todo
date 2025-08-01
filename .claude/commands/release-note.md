# ブランチの差分からAppleStoreとAppleStore用のリリースノートを自動作成する

## タスク

現在のブランチとmainブランチの差分を分析して、以下2種類のリリースノートを生成してください。

## 1. Apple Store用リリースノート

### 形式

- 「改善:」「バグ修正:」などのカテゴリで簡潔に記載
- 日本語と英語を分けて記載
- ユーザー目線でわかりやすく
- 技術的な詳細は含めない

### 例文

```
- 改善: タスク追加時に連続投稿できるようにするかを「設定 > 振る舞い」で切り替えられるようになりました
- バグ修正: 細かな不具合の修正とパフォーマンス改善を行いました
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

1. `git diff main...HEAD` でブランチの差分を確認
2. コミットメッセージ、変更されたファイル、コードの変更内容を分析
3. ユーザーに影響する変更を抽出
4. 上記の形式で2種類のリリースノートを生成
5. 技術的な内部実装の変更（リファクタリング、ライブラリの更新など）はユーザーに見えない限り含めない  
6. 内容の提示を行い、問題なければMCP経由で[Notionのリリースノート](https://www.notion.so/yumikokh/Release-Notes-18154c37a54c807b8ac6ef6612524378?source=copy_link)に反映する

## 注意事項

- ユーザーが理解しやすい言葉を使用
- 機能の利点を明確に伝える
- 日本語と英語で同じ内容を正確に伝える
- Notion用は詳細に、Apple Store用は簡潔に
