require "test_helper"

class FavoriteTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(name: "テストユーザー", email: "test@example.com")
    @favorite = Favorite.new(user: @user, fixture_id: 12345)
  end

  test "有効なお気に入りは保存できる" do
    assert @favorite.valid?
  end

  test "ユーザーは必須" do
    @favorite.user = nil
    assert_not @favorite.valid?
  end

  test "fixture_idは必須" do
    @favorite.fixture_id = nil
    assert_not @favorite.valid?
    assert @favorite.errors[:fixture_id].any?
  end

  test "同じユーザーが同じ試合を複数回お気に入り登録できない" do
    @favorite.save
    duplicate_favorite = Favorite.new(user: @user, fixture_id: 12345)
    assert_not duplicate_favorite.valid?
    assert duplicate_favorite.errors[:fixture_id].any?
  end

  test "異なるユーザーが同じ試合をお気に入り登録できる" do
    @favorite.save
    other_user = User.create!(name: "別のユーザー", email: "other@example.com")
    other_favorite = Favorite.new(user: other_user, fixture_id: 12345)
    assert other_favorite.valid?
  end

  test "同じユーザーが異なる試合をお気に入り登録できる" do
    @favorite.save
    another_favorite = Favorite.new(user: @user, fixture_id: 67890)
    assert another_favorite.valid?
  end

  test "ユーザーとの関連付け" do
    assert_respond_to @favorite, :user
    assert_equal @user, @favorite.user
  end
end
