require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "テストユーザー", email: "test@example.com")
  end

  test "有効なユーザーは保存できる" do
    assert @user.valid?
  end

  test "名前は必須" do
    @user.name = nil
    assert_not @user.valid?
    assert @user.errors[:name].any?
  end

  test "名前が空文字の場合は無効" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "メールアドレスは必須" do
    @user.email = nil
    assert_not @user.valid?
    assert @user.errors[:email].any?
  end

  test "メールアドレスが空文字の場合は無効" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "メールアドレスは一意である" do
    @user.save
    duplicate_user = User.new(name: "別のユーザー", email: "test@example.com")
    assert_not duplicate_user.valid?
    assert duplicate_user.errors[:email].any?
  end

  test "メールアドレスは大文字小文字を区別しない" do
    @user.save
    duplicate_user = User.new(name: "別のユーザー", email: "TEST@EXAMPLE.COM")
    assert_not duplicate_user.valid?
  end

  test "メールアドレスは小文字で保存される" do
    @user.email = "TEST@EXAMPLE.COM"
    @user.save
    assert_equal "test@example.com", @user.reload.email
  end

  test "無効なメールアドレス形式は拒否される" do
    invalid_emails = %w[user@ @example.com user example.com]
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email} は無効であるべき"
    end
  end

  test "有効なメールアドレス形式は受け入れられる" do
    valid_emails = %w[user@example.com USER@foo.COM user+tag@example.org]
    valid_emails.each do |valid_email|
      @user.email = valid_email
      assert @user.valid?, "#{valid_email} は有効であるべき"
    end
  end

  test "お気に入りとの関連付け" do
    assert_respond_to @user, :favorites
  end

  test "ユーザー削除時にお気に入りも削除される" do
    @user.save
    @user.favorites.create!(fixture_id: 12345)
    assert_difference "Favorite.count", -1 do
      @user.destroy
    end
  end

  test "favorited?メソッドはお気に入り登録済みの場合trueを返す" do
    @user.save
    @user.favorites.create!(fixture_id: 12345)
    assert @user.favorited?(12345)
  end

  test "favorited?メソッドはお気に入り未登録の場合falseを返す" do
    @user.save
    assert_not @user.favorited?(99999)
  end
end
