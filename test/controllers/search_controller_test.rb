require "test_helper"

class SearchControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "テストユーザー", email: "test@example.com")
  end

  def login_as(user)
    post login_path, params: { user_id: user.id }
  end

  test "未ログインでは検索画面にアクセスできない" do
    get search_path
    assert_redirected_to login_path
  end

  test "ログイン中は検索画面を表示できる" do
    login_as(@user)
    get search_path
    assert_response :success
  end

  test "英語でリーグを検索できる" do
    login_as(@user)
    get search_path, params: { q: "Premier" }
    assert_response :success
    assert_match "Premier League", response.body
  end

  test "日本語でリーグを検索できる" do
    login_as(@user)
    get search_path, params: { q: "プレミア" }
    assert_response :success
    assert_match "プレミアリーグ", response.body
  end

  test "英語でチームを検索できる" do
    login_as(@user)
    get search_path, params: { q: "Barcelona" }
    assert_response :success
    assert_match "Barcelona", response.body
  end

  test "日本語でチームを検索できる" do
    login_as(@user)
    get search_path, params: { q: "バルセロナ" }
    assert_response :success
    assert_match "バルセロナ", response.body
  end

  test "国名で検索できる" do
    login_as(@user)
    get search_path, params: { q: "Japan" }
    assert_response :success
    assert_match "J1 League", response.body
  end

  test "日本語の国名で検索できる" do
    login_as(@user)
    get search_path, params: { q: "日本" }
    assert_response :success
    assert_match "J1リーグ", response.body
  end

  test "検索結果が見つからない場合はメッセージを表示" do
    login_as(@user)
    get search_path, params: { q: "存在しないリーグ" }
    assert_response :success
    assert_match "検索結果が見つかりませんでした", response.body
  end

  test "リーグ選択でチーム一覧を取得できる" do
    login_as(@user)
    get search_teams_for_league_path, params: { league_id: 39 }
    assert_response :success

    json = JSON.parse(response.body)
    assert json.is_a?(Array)
    assert json.any?
    assert json.first["name"].present?
    assert json.first["name_ja"].present?
  end

  test "存在しないリーグIDでは空配列を返す" do
    login_as(@user)
    get search_teams_for_league_path, params: { league_id: 99999 }
    assert_response :success

    json = JSON.parse(response.body)
    assert_equal [], json
  end

  test "リーグとチームを選択して検索できる" do
    login_as(@user)
    get search_path, params: { league_id: 39, team_id: 33 }
    assert_response :success
    assert_match "マンチェスター・ユナイテッド", response.body
  end
end
