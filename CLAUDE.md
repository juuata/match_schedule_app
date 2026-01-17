# CLAUDE.md - 開発ルール

## プロジェクト概要

サッカー試合情報閲覧アプリ（Rails 7.1 + Tailwind CSS）

## よく使うコマンド

### サーバー起動

```bash
# 開発サーバー起動（Tailwind CSS自動ビルド付き）
bin/dev

# Railsサーバーのみ起動
rails server
```

### データベース

```bash
# データベース作成
rails db:create

# マイグレーション実行
rails db:migrate

# データベースリセット
rails db:reset
```

### Gem管理

```bash
# Gemインストール
bundle install

# Gem追加後
bundle install
```

### Tailwind CSS

```bash
# Tailwind CSSビルド
rails tailwindcss:build

# Tailwind CSS監視モード
rails tailwindcss:watch
```

### Rails関連

```bash
# ルーティング確認
rails routes

# コンソール起動
rails console

# コントローラー生成
rails generate controller ControllerName action1 action2

# モデル生成
rails generate model ModelName field:type
```

### テスト

```bash
# 全テスト実行
rails test

# 特定ファイルのテスト
rails test test/path/to/test_file.rb
```

---

## コーディング規約

### 全般

- Ruby 3.4.8 / Rails 7.1 を使用
- インデントは **スペース2つ**
- 文字列は **ダブルクォート** `"string"` を優先
- 末尾のカンマは省略
- 1行は **120文字以内**

### 命名規則

| 種別 | 規則 | 例 |
|------|------|-----|
| クラス | PascalCase | `MatchesController` |
| メソッド | snake_case | `current_season` |
| 変数 | snake_case | `league_id` |
| 定数 | SCREAMING_SNAKE_CASE | `POPULAR_LEAGUES` |
| ファイル | snake_case | `football_api_service.rb` |

### コントローラー

```ruby
class ExampleController < ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  def index
    @resources = Resource.all
  end

  private

  def set_resource
    @resource = Resource.find(params[:id])
  end
end
```

- `before_action` はクラス定義直後に記述
- プライベートメソッドは `private` キーワード以下に配置
- アクション順序: index, show, new, create, edit, update, destroy

### サービスクラス

```ruby
class ExampleService
  def initialize(param)
    @param = param
  end

  def call
    # メイン処理
  end

  private

  def helper_method
    # 補助処理
  end
end
```

- `app/services/` ディレクトリに配置
- 1クラス1責任の原則を守る
- 外部APIとの連携はサービスクラスに集約

### ビュー

```erb
<%# コメントはERBコメントで %>
<div class="container mx-auto">
  <%= render "shared/partial_name", local_var: @var %>
</div>
```

- パーシャルは `app/views/shared/` に配置（共通）または各コントローラーディレクトリ内
- Tailwind CSSクラスを使用
- インラインスタイルは使用しない

### API連携

```ruby
# 正しい例
result = @api_service.fixtures(league_id: 39, season: 2024)
@matches = result["response"] || []
@errors = result["errors"] if result["errors"].present?

# エラーハンドリングを忘れない
```

- APIレスポンスは必ず `[]` や `{}` でデフォルト値を設定
- エラーは `@errors` でビューに渡す

### 環境変数

```ruby
# config: 環境変数は ENV から取得
@api_key = ENV["FOOTBALL_API_KEY"]
```

- 機密情報は `.env` ファイルに記載
- `.env` は `.gitignore` に追加済み
- `.env.example` にサンプルを用意

---

## ディレクトリ構成

```
app/
├── controllers/          # コントローラー
├── helpers/              # ヘルパー
├── models/               # モデル（現在未使用）
├── services/             # サービスクラス（API連携等）
└── views/
    ├── layouts/          # レイアウト
    ├── shared/           # 共通パーシャル
    └── [controller]/     # 各コントローラーのビュー

config/
├── routes.rb             # ルーティング
└── environments/         # 環境設定

docs/
└── design.md             # 設計ドキュメント
```

---

## 外部API

### API-Football

- **ベースURL**: `https://v3.football.api-sports.io`
- **認証**: ヘッダー `x-apisports-key` にAPIキーを設定
- **レート制限**: 無料プランは1日100リクエスト
- **ドキュメント**: https://www.api-football.com/documentation-v3

### 主要エンドポイント

| エンドポイント | 用途 |
|---------------|------|
| `/fixtures` | 試合一覧・詳細 |
| `/standings` | 順位表 |
| `/leagues` | リーグ一覧 |

---

## Git運用

### ブランチ戦略

- `main`: 本番環境
- `develop`: 開発環境
- `feature/*`: 機能追加
- `fix/*`: バグ修正

### コミットメッセージ

```
[種別] 変更内容の要約

- feat: 新機能
- fix: バグ修正
- docs: ドキュメント
- style: フォーマット
- refactor: リファクタリング
- test: テスト
- chore: その他
```

例: `feat: 順位表機能を追加`
