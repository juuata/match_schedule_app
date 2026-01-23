require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "テストユーザー", email: "test@example.com")
  end

  def login_as(user)
    post login_path, params: { user_id: user.id }
  end

  test "未ログインではお気に入り一覧にアクセスできない" do
    get favorites_path
    assert_redirected_to login_path
  end

  test "ログイン中はお気に入り一覧を表示できる" do
    login_as(@user)
    get favorites_path
    assert_response :success
  end

  test "お気に入りに追加できる" do
    login_as(@user)
    assert_difference "Favorite.count", 1 do
      post favorites_path, params: { fixture_id: 12345 }
    end
  end

  test "お気に入りから削除できる" do
    login_as(@user)
    @user.favorites.create!(fixture_id: 12345)

    assert_difference "Favorite.count", -1 do
      delete favorites_path, params: { fixture_id: 12345 }
    end
  end

  test "同じ試合を重複してお気に入りに追加できない" do
    login_as(@user)
    @user.favorites.create!(fixture_id: 12345)

    assert_no_difference "Favorite.count" do
      post favorites_path, params: { fixture_id: 12345 }
    end
  end

  test "未ログインではお気に入りに追加できない" do
    assert_no_difference "Favorite.count" do
      post favorites_path, params: { fixture_id: 12345 }
    end
    assert_redirected_to login_path
  end

  test "お気に入り一覧にはユーザー自身のお気に入りのみ表示される" do
    other_user = User.create!(name: "別のユーザー", email: "other@example.com")
    @user.favorites.create!(fixture_id: 11111)
    other_user.favorites.create!(fixture_id: 22222)

    login_as(@user)
    get favorites_path
    assert_response :success
    # ユーザー自身のお気に入りのみ取得されている
    assert_equal 1, @user.favorites.count
  end
end
