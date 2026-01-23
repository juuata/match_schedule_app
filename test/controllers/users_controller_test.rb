require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "新規登録画面を表示できる" do
    get signup_path
    assert_response :success
    assert_select "h1", "新規登録"
  end

  test "有効なデータで新規登録できる" do
    assert_difference "User.count", 1 do
      post signup_path, params: {
        user: { name: "新規ユーザー", email: "newuser@example.com" }
      }
    end
    assert_redirected_to root_path
    # 自動ログインされている
    assert_not_nil session[:user_id]
  end

  test "名前なしでは登録できない" do
    assert_no_difference "User.count" do
      post signup_path, params: {
        user: { name: "", email: "newuser@example.com" }
      }
    end
    assert_response :unprocessable_entity
  end

  test "メールアドレスなしでは登録できない" do
    assert_no_difference "User.count" do
      post signup_path, params: {
        user: { name: "新規ユーザー", email: "" }
      }
    end
    assert_response :unprocessable_entity
  end

  test "重複したメールアドレスでは登録できない" do
    User.create!(name: "既存ユーザー", email: "existing@example.com")

    assert_no_difference "User.count" do
      post signup_path, params: {
        user: { name: "新規ユーザー", email: "existing@example.com" }
      }
    end
    assert_response :unprocessable_entity
  end

  test "無効なメールアドレス形式では登録できない" do
    assert_no_difference "User.count" do
      post signup_path, params: {
        user: { name: "新規ユーザー", email: "invalid-email" }
      }
    end
    assert_response :unprocessable_entity
  end
end
