require "test_helper"

class DummyDataServiceTest < ActiveSupport::TestCase
  def setup
    @service = DummyDataService.new
  end

  # LEAGUES定数のテスト
  test "LEAGUESには8つのリーグが含まれる" do
    assert_equal 8, DummyDataService::LEAGUES.size
  end

  test "各リーグにはid, name, name_ja, country, country_ja, logoが含まれる" do
    DummyDataService::LEAGUES.each do |id, league|
      assert league[:id].present?, "リーグID #{id} にはidが必要"
      assert league[:name].present?, "リーグID #{id} にはnameが必要"
      assert league[:name_ja].present?, "リーグID #{id} にはname_jaが必要"
      assert league[:country].present?, "リーグID #{id} にはcountryが必要"
      assert league[:country_ja].present?, "リーグID #{id} にはcountry_jaが必要"
      assert league[:logo].present?, "リーグID #{id} にはlogoが必要"
    end
  end

  test "プレミアリーグのデータが正しい" do
    premier = DummyDataService::LEAGUES[39]
    assert_equal "Premier League", premier[:name]
    assert_equal "プレミアリーグ", premier[:name_ja]
    assert_equal "England", premier[:country]
    assert_equal "イングランド", premier[:country_ja]
  end

  # TEAMS定数のテスト
  test "TEAMSには8つのリーグのチームが含まれる" do
    assert_equal 8, DummyDataService::TEAMS.size
  end

  test "各チームにはid, name, name_ja, logoが含まれる" do
    DummyDataService::TEAMS.each do |league_id, teams|
      teams.each do |team|
        assert team[:id].present?, "リーグ#{league_id}のチームにはidが必要"
        assert team[:name].present?, "リーグ#{league_id}のチームにはnameが必要"
        assert team[:name_ja].present?, "リーグ#{league_id}のチームにはname_jaが必要"
        assert team[:logo].present?, "リーグ#{league_id}のチームにはlogoが必要"
      end
    end
  end

  test "プレミアリーグには8チームが含まれる" do
    assert_equal 8, DummyDataService::TEAMS[39].size
  end

  # fixturesメソッドのテスト
  test "fixturesは試合データを返す" do
    result = @service.fixtures(league_id: 39, season: 2024)
    assert result["response"].is_a?(Array)
  end

  test "fixturesのレスポンスには試合情報が含まれる" do
    result = @service.fixtures(league_id: 39, season: 2024)
    assert result["response"].any?

    match = result["response"].first
    assert match["fixture"].present?
    assert match["teams"].present?
    assert match["goals"].present?
    assert match["league"].present?
  end

  # fixtureメソッドのテスト
  test "fixtureは単一の試合データを返す" do
    result = @service.fixture(1001)
    assert result["response"].is_a?(Array)
    assert_equal 1, result["response"].size
  end

  # standingsメソッドのテスト
  test "standingsは順位表データを返す" do
    result = @service.standings(league_id: 39, season: 2024)
    assert result["response"].is_a?(Array)
  end

  # live_fixturesメソッドのテスト
  test "live_fixturesはライブ試合データを返す" do
    result = @service.live_fixtures
    assert result["response"].is_a?(Array)
  end
end
