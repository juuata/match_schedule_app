require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "nav_link_toは通常のリンクを生成する" do
    # current_page?をモック
    def current_page?(path)
      false
    end

    result = nav_link_to("テスト", "/test")
    assert_match /href="\/test"/, result
    assert_match /テスト/, result
    assert_match /text-gray-700/, result
    assert_no_match /text-green-600/, result
  end

  test "nav_link_toはアクティブなリンクにハイライトクラスを適用する" do
    # current_page?をモック（アクティブ）
    def current_page?(path)
      true
    end

    result = nav_link_to("テスト", "/test")
    assert_match /text-green-600/, result
    assert_match /border-green-600/, result
    assert_match /bg-green-50/, result
  end

  test "nav_link_toはブロックを受け取れる" do
    def current_page?(path)
      false
    end

    result = nav_link_to("/test") { "ブロックコンテンツ" }
    assert_match /href="\/test"/, result
    assert_match /ブロックコンテンツ/, result
  end
end
