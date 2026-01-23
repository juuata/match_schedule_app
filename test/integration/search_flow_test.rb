require "test_helper"

class SearchFlowTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "テストユーザー", email: "test@example.com")
  end

  def login_as(user)
    post login_path, params: { user_id: user.id }
  end

  test "キーワード検索でリーグを見つけて試合日程に遷移" do
    login_as(@user)

    # 1. 検索画面にアクセス
    get search_path
    assert_response :success

    # 2. 英語でリーグを検索
    get search_path, params: { q: "Premier" }
    assert_response :success
    assert_match "Premier League", response.body
    assert_match "プレミアリーグ", response.body

    # 3. 検索結果から試合日程に遷移
    get schedule_matches_path, params: { league_id: 39 }
    assert_response :success
    assert_match "試合日程", response.body
  end

  test "日本語キーワード検索でリーグを見つける" do
    login_as(@user)

    # 日本語でリーグを検索
    get search_path, params: { q: "プレミア" }
    assert_response :success
    assert_match "プレミアリーグ", response.body

    # 国名で検索
    get search_path, params: { q: "日本" }
    assert_response :success
    assert_match "J1リーグ", response.body

    # イングランドで検索
    get search_path, params: { q: "イングランド" }
    assert_response :success
    assert_match "プレミアリーグ", response.body
  end

  test "キーワード検索でチームを見つけて所属リーグの順位表に遷移" do
    login_as(@user)

    # 1. 英語でチームを検索
    get search_path, params: { q: "Barcelona" }
    assert_response :success
    assert_match "Barcelona", response.body
    assert_match "バルセロナ", response.body
    assert_match "La Liga", response.body

    # 2. 日本語でチームを検索
    get search_path, params: { q: "バルセロナ" }
    assert_response :success
    assert_match "バルセロナ", response.body

    # 3. 順位表に遷移
    get standings_matches_path, params: { league_id: 140 }
    assert_response :success
    assert_match "順位表", response.body
  end

  test "ドロップダウンでリーグを選択してチーム一覧を取得" do
    login_as(@user)

    # 1. 検索画面にアクセス
    get search_path
    assert_response :success

    # 2. リーグ選択時のAPI呼び出し（プレミアリーグ）
    get search_teams_for_league_path, params: { league_id: 39 }
    assert_response :success

    json = JSON.parse(response.body)
    assert json.is_a?(Array)
    assert json.size > 0

    # チームデータの確認
    team_names = json.map { |t| t["name"] }
    assert_includes team_names, "Manchester United"
    assert_includes team_names, "Liverpool"
  end

  test "ドロップダウンでリーグとチームを選択して検索" do
    login_as(@user)

    # リーグとチームを選択して検索
    get search_path, params: { league_id: 39, team_id: 33 }
    assert_response :success
    assert_match "マンチェスター・ユナイテッド", response.body
    assert_match "Manchester United", response.body
    assert_match "プレミアリーグ", response.body
  end

  test "検索結果が見つからない場合のメッセージ表示" do
    login_as(@user)

    get search_path, params: { q: "存在しないリーグ名" }
    assert_response :success
    assert_match "検索結果が見つかりませんでした", response.body
  end

  test "空の検索クエリの場合" do
    login_as(@user)

    get search_path, params: { q: "" }
    assert_response :success
    # 検索結果は表示されない
    assert_no_match "リーグ \\(", response.body
    assert_no_match "チーム \\(", response.body
  end

  test "複数のリーグがヒットする検索" do
    login_as(@user)

    # "League"で検索すると複数ヒット
    get search_path, params: { q: "League" }
    assert_response :success
    assert_match "Premier League", response.body
    assert_match "J1 League", response.body
    assert_match "Champions League", response.body
    assert_match "Europa League", response.body
  end

  test "ナビゲーションから検索画面に遷移" do
    login_as(@user)

    # リーグ一覧から検索へ
    get leagues_path
    assert_response :success
    assert_match "検索", response.body

    get search_path
    assert_response :success
    assert_match "キーワードで検索", response.body
    assert_match "リーグ・チームから検索", response.body
  end

  test "未ログインでは検索できない" do
    get search_path
    assert_redirected_to login_path

    get search_path, params: { q: "Premier" }
    assert_redirected_to login_path

    get search_teams_for_league_path, params: { league_id: 39 }
    assert_redirected_to login_path
  end
end
