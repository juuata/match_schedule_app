require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "テストユーザー", email: "test@example.com")
  end

  test "ログイン画面を表示できる" do
    get login_path
    assert_response :success
    assert_select "h1", "ログイン"
  end

  test "有効なユーザーでログインできる" do
    post login_path, params: { user_id: @user.id }
    assert_redirected_to root_path
    assert_equal @user.id, session[:user_id]
  end

  test "無効なユーザーIDではログインできない" do
    post login_path, params: { user_id: 99999 }
    assert_response :unprocessable_entity
    assert_nil session[:user_id]
  end

  test "ユーザーIDなしではログインできない" do
    post login_path, params: { user_id: "" }
    assert_response :unprocessable_entity
    assert_nil session[:user_id]
  end

  test "ログアウトできる" do
    # まずログイン
    post login_path, params: { user_id: @user.id }

    # ログアウト
    delete logout_path
    assert_redirected_to login_path
    assert_nil session[:user_id]
  end

  test "ログアウト後にフラッシュメッセージが表示される" do
    post login_path, params: { user_id: @user.id }
    delete logout_path
    follow_redirect!
    assert_match "ログアウトしました", response.body
  end
end
