require "test_helper"

class MatchBrowsingFlowTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "テストユーザー", email: "test@example.com")
  end

  def login_as(user)
    post login_path, params: { user_id: user.id }
  end

  test "リーグ一覧から試合日程、試合詳細への遷移" do
    login_as(@user)

    # 1. リーグ一覧
    get leagues_path
    assert_response :success
    assert_match "Premier League", response.body
    assert_match "La Liga", response.body
    assert_match "J1 League", response.body

    # 2. 試合日程へ
    get schedule_matches_path, params: { league_id: 39 }
    assert_response :success
    assert_match "試合日程", response.body

    # 3. 試合詳細へ
    get match_path(1001)
    assert_response :success
  end

  test "リーグ一覧から試合結果への遷移" do
    login_as(@user)

    # 1. リーグ一覧
    get leagues_path
    assert_response :success

    # 2. 試合結果へ
    get results_matches_path, params: { league_id: 39 }
    assert_response :success
    assert_match "試合結果", response.body
  end

  test "リーグ一覧から順位表への遷移" do
    login_as(@user)

    # 1. リーグ一覧
    get leagues_path
    assert_response :success

    # 2. 順位表へ
    get standings_matches_path, params: { league_id: 39 }
    assert_response :success
    assert_match "順位表", response.body
  end

  test "ライブ試合一覧の表示" do
    login_as(@user)

    get live_matches_path
    assert_response :success
    assert_match "ライブ", response.body
  end

  test "ナビゲーションから各ページへの遷移" do
    login_as(@user)

    # 各ナビゲーションリンクをテスト
    pages = [
      { path: leagues_path, match: "リーグ一覧" },
      { path: schedule_matches_path, match: "試合日程" },
      { path: results_matches_path, match: "試合結果" },
      { path: live_matches_path, match: "ライブ" },
      { path: favorites_path, match: "お気に入り" },
      { path: search_path, match: "検索" }
    ]

    pages.each do |page|
      get page[:path]
      assert_response :success, "#{page[:path]} にアクセスできるべき"
    end
  end

  test "試合詳細からお気に入りに追加して一覧で確認" do
    login_as(@user)

    # 1. 試合詳細へ
    get match_path(1001)
    assert_response :success

    # 2. お気に入りに追加
    post favorites_path, params: { fixture_id: 1001 }

    # 3. お気に入り一覧で確認
    get favorites_path
    assert_response :success
    assert_equal 1, @user.favorites.count
  end

  test "リーグIDを指定しない場合のデフォルト表示" do
    login_as(@user)

    # リーグID指定なしでも表示できる
    get schedule_matches_path
    assert_response :success

    get results_matches_path
    assert_response :success
  end

  test "存在しない試合IDの場合" do
    login_as(@user)

    get match_path(99999)
    assert_response :success
    # エラーメッセージまたは「見つかりません」が表示される
  end

  test "ホームページからリーグ一覧へのリダイレクト" do
    login_as(@user)

    get root_path
    assert_redirected_to "/leagues"
    follow_redirect!
    assert_response :success
    assert_match "リーグ一覧", response.body
  end

  test "未ログインでは試合ページにアクセスできない" do
    pages = [
      leagues_path,
      schedule_matches_path,
      results_matches_path,
      live_matches_path,
      standings_matches_path,
      match_path(1001)
    ]

    pages.each do |path|
      get path
      assert_redirected_to login_path, "#{path} は未ログインではアクセスできないべき"
    end
  end
end
