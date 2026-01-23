require "test_helper"

class MatchesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "テストユーザー", email: "test@example.com")
  end

  def login_as(user)
    post login_path, params: { user_id: user.id }
  end

  # 認証テスト
  test "未ログインでは試合日程にアクセスできない" do
    get schedule_matches_path
    assert_redirected_to login_path
  end

  test "未ログインでは試合結果にアクセスできない" do
    get results_matches_path
    assert_redirected_to login_path
  end

  test "未ログインではライブにアクセスできない" do
    get live_matches_path
    assert_redirected_to login_path
  end

  test "未ログインでは順位表にアクセスできない" do
    get standings_matches_path
    assert_redirected_to login_path
  end

  # 試合日程
  test "ログイン中は試合日程を表示できる" do
    login_as(@user)
    get schedule_matches_path
    assert_response :success
    assert_match "試合日程", response.body
  end

  test "リーグIDを指定して試合日程を表示できる" do
    login_as(@user)
    get schedule_matches_path, params: { league_id: 39 }
    assert_response :success
  end

  # 試合結果
  test "ログイン中は試合結果を表示できる" do
    login_as(@user)
    get results_matches_path
    assert_response :success
    assert_match "試合結果", response.body
  end

  test "リーグIDを指定して試合結果を表示できる" do
    login_as(@user)
    get results_matches_path, params: { league_id: 39 }
    assert_response :success
  end

  # ライブ
  test "ログイン中はライブを表示できる" do
    login_as(@user)
    get live_matches_path
    assert_response :success
    assert_match "ライブ", response.body
  end

  # 順位表
  test "ログイン中は順位表を表示できる" do
    login_as(@user)
    get standings_matches_path, params: { league_id: 39 }
    assert_response :success
    assert_match "順位表", response.body
  end

  # 試合詳細
  test "試合詳細を表示できる" do
    login_as(@user)
    get match_path(1001)
    assert_response :success
  end
end
