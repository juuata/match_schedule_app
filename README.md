# Football Match Schedule App

サッカーの試合日程・結果を閲覧できるRailsアプリケーションです。API-Footballと連携してリアルタイムの試合情報を表示します。

## 機能

- **リーグ一覧**: プレミアリーグ、ラ・リーガ、セリエA、ブンデスリーガ、リーグ・アン、Jリーグ、チャンピオンズリーグなど
- **試合スケジュール**: 今後の試合予定を日付範囲で絞り込み表示
- **試合結果**: 最近の試合結果を表示
- **ライブ試合**: 現在進行中の試合をリアルタイム表示
- **順位表**: 各リーグの順位表を表示
- **試合詳細**: 試合の詳細情報（スコア、会場、審判など）

## セットアップ

### 1. APIキーの取得

API-Footballのキーを取得してください：

- 公式サイト: https://www.api-football.com/
- RapidAPI経由: https://rapidapi.com/api-sports/api/api-football

無料プランでは1日100リクエストまで利用可能です。

### 2. 環境変数の設定

```bash
cp .env.example .env
```

`.env`ファイルを編集してAPIキーを設定：

```
FOOTBALL_API_KEY=your_api_key_here
```

### 3. 依存関係のインストール

```bash
bundle install
```

### 4. データベースの作成

```bash
rails db:create
```

### 5. サーバーの起動

```bash
bin/dev
```

http://localhost:3000 でアクセスできます。

## 使用技術

- Ruby 3.4.8
- Rails 7.1
- Tailwind CSS
- Faraday (HTTPクライアント)
- API-Football (外部API)

## 対応リーグ

| リーグ | ID |
|--------|-----|
| Premier League | 39 |
| La Liga | 140 |
| Serie A | 135 |
| Bundesliga | 78 |
| Ligue 1 | 61 |
| J1 League | 98 |
| Champions League | 2 |
| Europa League | 3 |

## ディレクトリ構成

```
app/
├── controllers/
│   ├── application_controller.rb
│   ├── favorites_controller.rb   # お気に入り管理
│   ├── leagues_controller.rb     # リーグ一覧
│   ├── matches_controller.rb     # 試合関連
│   ├── search_controller.rb      # 検索機能
│   ├── sessions_controller.rb    # ログイン/ログアウト
│   └── users_controller.rb       # ユーザー登録
├── models/
│   ├── favorite.rb               # お気に入りモデル
│   └── user.rb                   # ユーザーモデル
├── services/
│   ├── dummy_data_service.rb     # ダミーデータ生成
│   └── football_api_service.rb   # API連携
└── views/
    ├── favorites/
    ├── layouts/
    ├── leagues/
    ├── matches/
    ├── search/
    ├── sessions/
    ├── shared/
    └── users/

test/
├── controllers/                   # コントローラーテスト
├── helpers/                       # ヘルパーテスト
├── integration/                   # 結合テスト
├── models/                        # モデルテスト
└── services/                      # サービステスト
```
