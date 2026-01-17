# 設計ドキュメント

## 機能仕様

### 機能一覧

| No | 機能名 | 説明 | エンドポイント |
|----|--------|------|----------------|
| 1 | リーグ一覧 | 対応リーグの一覧を表示 | `GET /` |
| 2 | 試合一覧（日別） | 指定日の試合一覧を表示 | `GET /matches` |
| 3 | 試合詳細 | 試合の詳細情報を表示 | `GET /matches/:id` |
| 4 | 試合スケジュール | 期間指定で今後の試合予定を表示 | `GET /matches/schedule` |
| 5 | 試合結果 | 最近の試合結果を表示 | `GET /matches/results` |
| 6 | ライブ試合 | 現在進行中の試合を表示 | `GET /matches/live` |
| 7 | 順位表 | リーグ順位表を表示 | `GET /matches/standings` |

### 機能詳細

#### 1. リーグ一覧 (`LeaguesController#index`)

- **概要**: 対応しているサッカーリーグの一覧を表示
- **パラメータ**: なし
- **表示項目**: リーグ名、国名、ロゴ
- **対応リーグ**:
  - Premier League (ID: 39)
  - La Liga (ID: 140)
  - Serie A (ID: 135)
  - Bundesliga (ID: 78)
  - Ligue 1 (ID: 61)
  - J1 League (ID: 98)
  - UEFA Champions League (ID: 2)
  - UEFA Europa League (ID: 3)

#### 2. 試合一覧 (`MatchesController#index`)

- **概要**: 指定日・指定リーグの試合一覧を表示
- **パラメータ**:
  - `date` (任意): 日付 (デフォルト: 今日)
  - `league_id` (任意): リーグID (デフォルト: 39)
- **表示項目**: ホームチーム、アウェイチーム、スコア/キックオフ時間、試合状態

#### 3. 試合詳細 (`MatchesController#show`)

- **概要**: 個別試合の詳細情報を表示
- **パラメータ**: `id` (必須): 試合ID
- **表示項目**:
  - チーム情報（ロゴ、名前）
  - スコア（前半、後半、延長、PK戦）
  - 会場情報
  - 審判情報
  - 試合状態

#### 4. 試合スケジュール (`MatchesController#schedule`)

- **概要**: 期間を指定して今後の試合予定を表示
- **パラメータ**:
  - `from` (任意): 開始日 (デフォルト: 今日)
  - `to` (任意): 終了日 (デフォルト: 7日後)
  - `league_id` (任意): リーグID (デフォルト: 39)
- **表示項目**: 日付ごとにグループ化された試合一覧

#### 5. 試合結果 (`MatchesController#results`)

- **概要**: 終了した試合の結果を表示（最新20件）
- **パラメータ**:
  - `league_id` (任意): リーグID (デフォルト: 39)
- **表示項目**: 終了済み試合のスコア、勝敗表示

#### 6. ライブ試合 (`MatchesController#live`)

- **概要**: 現在進行中の全リーグの試合を表示
- **パラメータ**: なし
- **表示項目**: リアルタイムスコア、経過時間

#### 7. 順位表 (`MatchesController#standings`)

- **概要**: 指定リーグの順位表を表示
- **パラメータ**:
  - `league_id` (任意): リーグID (デフォルト: 39)
- **表示項目**:
  - 順位、チーム名
  - 試合数、勝、分、負
  - 得点、失点、得失点差
  - 勝点、直近5試合のフォーム

---

## 構造仕様

### システムアーキテクチャ

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│                 │     │                 │     │                 │
│    Browser      │────▶│  Rails App      │────▶│  API-Football   │
│                 │     │                 │     │  (External API) │
│                 │◀────│                 │◀────│                 │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

### コンポーネント構成

```
app/
├── controllers/
│   ├── application_controller.rb   # ベースコントローラー
│   ├── leagues_controller.rb       # リーグ一覧
│   └── matches_controller.rb       # 試合関連機能
├── services/
│   └── football_api_service.rb     # API連携サービス
└── views/
    ├── layouts/
    │   └── application.html.erb    # 共通レイアウト
    ├── leagues/
    │   └── index.html.erb          # リーグ一覧
    ├── matches/
    │   ├── index.html.erb          # 試合一覧
    │   ├── show.html.erb           # 試合詳細
    │   ├── schedule.html.erb       # スケジュール
    │   ├── results.html.erb        # 結果
    │   ├── live.html.erb           # ライブ
    │   └── standings.html.erb      # 順位表
    └── shared/
        ├── _match_card.html.erb    # 試合カードパーシャル
        └── _league_selector.html.erb # リーグ選択パーシャル
```

### ER図

本アプリケーションはデータベースを使用せず、外部API（API-Football）からリアルタイムでデータを取得します。

```
※ データベーステーブルなし
※ 全データは API-Football から取得
```

### 外部APIデータ構造

#### API-Football レスポンス構造

**Fixture（試合）データ**
```json
{
  "fixture": {
    "id": 123456,
    "date": "2025-01-17T15:00:00+00:00",
    "venue": { "name": "Stadium Name", "city": "City" },
    "status": { "short": "FT", "elapsed": 90 },
    "referee": "Referee Name"
  },
  "league": {
    "id": 39,
    "name": "Premier League",
    "logo": "https://..."
  },
  "teams": {
    "home": { "id": 1, "name": "Team A", "logo": "https://...", "winner": true },
    "away": { "id": 2, "name": "Team B", "logo": "https://...", "winner": false }
  },
  "goals": { "home": 2, "away": 1 },
  "score": {
    "halftime": { "home": 1, "away": 0 },
    "fulltime": { "home": 2, "away": 1 },
    "extratime": { "home": null, "away": null },
    "penalty": { "home": null, "away": null }
  }
}
```

**Standings（順位表）データ**
```json
{
  "rank": 1,
  "team": { "id": 1, "name": "Team A", "logo": "https://..." },
  "points": 45,
  "goalsDiff": 25,
  "form": "WWDWW",
  "all": {
    "played": 20,
    "win": 14,
    "draw": 3,
    "lose": 3,
    "goals": { "for": 40, "against": 15 }
  }
}
```

### 試合ステータス一覧

| コード | 説明 |
|--------|------|
| NS | Not Started（未開始） |
| 1H | First Half（前半） |
| HT | Half Time（ハーフタイム） |
| 2H | Second Half（後半） |
| ET | Extra Time（延長戦） |
| P | Penalty（PK戦） |
| FT | Full Time（試合終了） |
| AET | After Extra Time（延長後終了） |
| PEN | Penalty Shootout（PK戦後終了） |

### シーズン判定ロジック

```ruby
def current_season
  today = Date.today
  today.month >= 7 ? today.year : today.year - 1
end
```

- 7月以降: 当年のシーズン
- 1月〜6月: 前年のシーズン
