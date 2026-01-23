require "test_helper"

class FavoriteFlowTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "テストユーザー", email: "test@example.com")
    @other_user = User.create!(name: "別のユーザー", email: "other@example.com")
  end

  def login_as(user)
    post login_path, params: { user_id: user.id }
  end

  test "お気に入りの追加から削除までの一連のフロー" do
    login_as(@user)

    # 1. 最初はお気に入りが空
    get favorites_path
    assert_response :success
    assert_match "お気に入りに登録された試合はありません", response.body

    # 2. お気に入りに追加
    assert_difference "Favorite.count", 1 do
      post favorites_path, params: { fixture_id: 1001 }
    end

    # 3. お気に入り一覧に表示される
    get favorites_path
    assert_response :success
    assert_equal 1, @user.favorites.count

    # 4. お気に入りから削除
    assert_difference "Favorite.count", -1 do
      delete favorites_path, params: { fixture_id: 1001 }
    end

    # 5. お気に入りが空に戻る
    get favorites_path
    assert_response :success
    assert_equal 0, @user.favorites.count
  end

  test "複数の試合をお気に入りに追加できる" do
    login_as(@user)

    # 複数の試合を追加
    post favorites_path, params: { fixture_id: 1001 }
    post favorites_path, params: { fixture_id: 1002 }
    post favorites_path, params: { fixture_id: 1003 }

    assert_equal 3, @user.favorites.count

    # 一覧で確認
    get favorites_path
    assert_response :success
  end

  test "同じ試合を重複してお気に入りに追加できない" do
    login_as(@user)

    # 最初の追加は成功
    assert_difference "Favorite.count", 1 do
      post favorites_path, params: { fixture_id: 1001 }
    end

    # 2回目は追加されない
    assert_no_difference "Favorite.count" do
      post favorites_path, params: { fixture_id: 1001 }
    end
  end

  test "お気に入りはユーザーごとに独立している" do
    # ユーザー1がお気に入りに追加
    login_as(@user)
    post favorites_path, params: { fixture_id: 1001 }
    post favorites_path, params: { fixture_id: 1002 }
    delete logout_path

    # ユーザー2がログイン
    login_as(@other_user)

    # ユーザー2のお気に入りは空
    get favorites_path
    assert_response :success
    assert_equal 0, @other_user.favorites.count

    # ユーザー2も同じ試合をお気に入りに追加できる
    assert_difference "Favorite.count", 1 do
      post favorites_path, params: { fixture_id: 1001 }
    end

    # ユーザー1のお気に入りは影響を受けない
    assert_equal 2, @user.favorites.count
    assert_equal 1, @other_user.favorites.count
  end

  test "未ログインではお気に入り操作ができない" do
    # お気に入り一覧
    get favorites_path
    assert_redirected_to login_path

    # お気に入り追加
    assert_no_difference "Favorite.count" do
      post favorites_path, params: { fixture_id: 1001 }
    end
    assert_redirected_to login_path

    # お気に入り削除
    delete favorites_path, params: { fixture_id: 1001 }
    assert_redirected_to login_path
  end

  test "試合詳細ページからお気に入りに追加できる" do
    login_as(@user)

    # 試合詳細ページにアクセス
    get match_path(1001)
    assert_response :success

    # お気に入りに追加
    assert_difference "Favorite.count", 1 do
      post favorites_path, params: { fixture_id: 1001 }
    end
  end
end
