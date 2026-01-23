require "test_helper"

class UserAuthenticationFlowTest < ActionDispatch::IntegrationTest
  test "新規登録からログアウトまでの一連のフロー" do
    # 1. 未ログイン状態でホームにアクセスするとログイン画面にリダイレクト
    get root_path
    follow_redirect!
    assert_redirected_to login_path

    # 2. 新規登録画面にアクセス
    get signup_path
    assert_response :success
    assert_select "h1", "新規登録"

    # 3. 新規ユーザーを登録
    assert_difference "User.count", 1 do
      post signup_path, params: {
        user: { name: "新規テストユーザー", email: "newtest@example.com" }
      }
    end

    # 4. 自動ログインされてホームにリダイレクト
    assert_redirected_to root_path
    follow_redirect!
    assert_redirected_to "/leagues"
    follow_redirect!
    assert_response :success

    # 5. ナビゲーションにユーザー名が表示される
    assert_match "新規テストユーザー", response.body
    assert_match "ログアウト", response.body

    # 6. ログアウト
    delete logout_path
    assert_redirected_to login_path
    follow_redirect!
    assert_response :success
    assert_match "ログアウトしました", response.body

    # 7. ログアウト後はホームにアクセスできない
    get leagues_path
    assert_redirected_to login_path
  end

  test "既存ユーザーでログインしてログアウト" do
    # ユーザーを作成
    user = User.create!(name: "既存ユーザー", email: "existing@example.com")

    # 1. ログイン画面にアクセス
    get login_path
    assert_response :success
    assert_select "h1", "ログイン"

    # 2. ログイン
    post login_path, params: { user_id: user.id }
    assert_redirected_to root_path
    follow_redirect!
    follow_redirect!
    assert_response :success

    # 3. ログイン後は各ページにアクセスできる
    get leagues_path
    assert_response :success

    get schedule_matches_path
    assert_response :success

    get results_matches_path
    assert_response :success

    get favorites_path
    assert_response :success

    get search_path
    assert_response :success

    # 4. ログアウト
    delete logout_path
    assert_redirected_to login_path

    # 5. ログアウト後はアクセスできない
    get leagues_path
    assert_redirected_to login_path
  end

  test "無効なユーザーIDでログインを試みる" do
    get login_path
    assert_response :success

    # 存在しないユーザーIDでログイン試行
    post login_path, params: { user_id: 99999 }
    assert_response :unprocessable_entity

    # ログイン画面のままで、保護されたページにはアクセスできない
    get leagues_path
    assert_redirected_to login_path
  end

  test "新規登録時のバリデーションエラー" do
    get signup_path
    assert_response :success

    # 1. 名前なしで登録試行
    assert_no_difference "User.count" do
      post signup_path, params: {
        user: { name: "", email: "test@example.com" }
      }
    end
    assert_response :unprocessable_entity

    # 2. メールなしで登録試行
    assert_no_difference "User.count" do
      post signup_path, params: {
        user: { name: "テスト", email: "" }
      }
    end
    assert_response :unprocessable_entity

    # 3. 重複メールで登録試行
    User.create!(name: "既存", email: "duplicate@example.com")
    assert_no_difference "User.count" do
      post signup_path, params: {
        user: { name: "テスト", email: "duplicate@example.com" }
      }
    end
    assert_response :unprocessable_entity
  end
end
