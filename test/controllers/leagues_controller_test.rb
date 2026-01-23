require "test_helper"

class LeaguesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "テストユーザー", email: "test@example.com")
  end

  def login_as(user)
    post login_path, params: { user_id: user.id }
  end

  test "未ログインではリーグ一覧にアクセスできない" do
    get leagues_path
    assert_redirected_to login_path
  end

  test "ログイン中はリーグ一覧を表示できる" do
    login_as(@user)
    get leagues_path
    assert_response :success
  end

  test "リーグ一覧にはPOPULAR_LEAGUESが表示される" do
    login_as(@user)
    get leagues_path
    assert_response :success
    assert_match "Premier League", response.body
    assert_match "La Liga", response.body
    assert_match "J1 League", response.body
  end

  test "各リーグには試合日程・試合結果・順位表へのリンクがある" do
    login_as(@user)
    get leagues_path
    assert_response :success
    assert_match "試合日程", response.body
    assert_match "試合結果", response.body
    assert_match "順位表", response.body
  end
end
