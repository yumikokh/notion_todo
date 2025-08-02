# Git Worktree Auto-Setup for Flutter Projects

Flutterプロジェクトで`git worktree`を使用する際に、gitignoreされたファイル（依存関係、環境ファイルなど）を自動的にセットアップするツールです。

## 🚀 特徴

- **自動セットアップ**: `git worktree add`実行時に自動的にFlutter依存関係をインストール
- **デフォルトパス管理**: worktreeを`./notion_todo.worktrees/`ディレクトリに整理
- **環境ファイルの自動コピー**: `.env`やFirebase設定ファイルを自動複製
- **iOS対応**: CocoaPodsの自動インストール
- **build_runner対応**: 必要に応じて自動実行
- **Copy-on-Write対応**: macOSで効率的なファイルコピー

## 📦 インストール

```bash
# インストール
cd scripts/worktree
./install_worktree_hook.sh install

# アンインストール
./install_worktree_hook.sh uninstall
```

インストール時に以下が設定されます：

1. **post-checkoutフック**: worktree作成時に自動実行
2. **Gitエイリアス**: 便利なコマンドショートカット

## 🔧 使用方法

### 方法1: 簡単作成（デフォルトパス使用）

```bash
# デフォルトパス（./notion_todo.worktrees/feature-name）に作成
./scripts/worktree/setup_worktree.sh create feature-name

# 環境ファイルも一緒にコピー
./scripts/worktree/setup_worktree.sh create feature-name "" ../main-worktree
```

### 方法2: 標準のgit worktreeコマンド（フック経由）

```bash
# 自動セットアップが実行される
git worktree add -b feature/new ../feature-branch
```

### 方法3: カスタムGitエイリアス

```bash
# 既存ブランチでworktreeを作成
git wtadd ../feature-branch feature/existing-branch

# 新規ブランチでworktreeを作成
git wtcreate feature/new-feature ../feature-branch

# 現在のworktreeをセットアップ
git wtsetup

# 環境ファイルをコピーしてセットアップ
git wtsetup ../main-worktree
```

### 方法4: 手動実行（カスタムパス）

```bash
# カスタムパスで作成
./scripts/worktree/setup_worktree.sh create feature/new ../custom-path

# 環境ファイルもコピー
./scripts/worktree/setup_worktree.sh create feature/new ../custom-path ../main-worktree

# 現在のディレクトリでセットアップ
./scripts/worktree/setup_worktree.sh setup
```

## 📋 自動セットアップの内容

1. **Flutter依存関係のインストール**

   ```bash
   flutter pub get
   ```

2. **iOS Podsのインストール**

   ```bash
   cd ios && pod install
   ```

3. **build_runnerの実行**（必要な場合）

   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **環境ファイルのコピー**
   - `.env`, `.env.local`, `.env.development`, `.env.production`
   - `env.json`, `config.json`
   - `ios/Runner/GoogleService-Info.plist`（Firebase iOS設定）
   - `android/app/google-services.json`（Firebase Android設定）

## 🛠️ カスタマイズ

### 環境ファイルの追加

`setup_worktree.sh`の`env_files`配列を編集：

```bash
env_files=(".env" ".env.local" "custom-config.json")
```

### デフォルトパスの変更

`setup_worktree.sh`の`DEFAULT_WORKTREE_DIR`を編集：

```bash
DEFAULT_WORKTREE_DIR="./my-worktrees"
```

## ⚙️ 要件

- Git 2.5以上（worktree機能）
- Flutter SDK
- Bash
- CocoaPods（iOS開発の場合）

## 🔍 トラブルシューティング

### フックが実行されない

```bash
# フックの確認
ls -la .git/hooks/post-checkout

# 再インストール
cd scripts/worktree
./install_worktree_hook.sh install
```

### 環境ファイルがコピーされない

メインworktreeのパスを明示的に指定：

```bash
./scripts/worktree/setup_worktree.sh setup /path/to/main-worktree
```

### build_runnerでエラーが発生する

一時的にbuild_runnerをスキップ：

```bash
# setup_worktree.shのsetup_generated_files行をコメントアウト
```

## 📝 ファイル構成

```
scripts/worktree/
├── setup_worktree.sh          # メインセットアップスクリプト
├── install_worktree_hook.sh   # インストール/アンインストールスクリプト
├── hooks/
│   └── post-checkout          # Gitフック
└── README.md                  # このドキュメント
```

## 💡 使用例

### 新機能開発用のworktreeを作成

```bash
# デフォルトパスに作成（推奨）
./scripts/worktree/setup_worktree.sh create feature/user-auth

# 作成されたworktreeに移動
cd notion_todo.worktrees/feature/user-auth
```

### 複数のworktreeを管理

```bash
# worktree一覧を確認
git worktree list

# 不要なworktreeを削除
git worktree remove notion_todo.worktrees/old-feature
```

## 📄 ライセンス

プロジェクトのライセンスに準じます。
