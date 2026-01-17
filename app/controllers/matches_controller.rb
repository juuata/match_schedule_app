class MatchesController < ApplicationController
  before_action :set_api_service
  before_action :set_dummy_mode_notice

  def index
    @date = params[:date] || Date.today.to_s
    @league_id = params[:league_id] || 39 # Premier League by default

    result = @api_service.fixtures(
      league_id: @league_id,
      season: current_season,
      date: @date
    )

    @matches = result["response"] || []
    @errors = result["errors"] if result["errors"].present?
  end

  def show
    result = @api_service.fixture(params[:id])
    @match = result["response"]&.first
    @errors = result["errors"] if result["errors"].present?
  end

  def schedule
    @from_date = params[:from] || Date.today.to_s
    @to_date = params[:to] || (Date.today + 7).to_s
    @league_id = params[:league_id] || 39

    result = @api_service.fixtures(
      league_id: @league_id,
      season: current_season,
      from: @from_date,
      to: @to_date
    )

    @matches = (result["response"] || []).group_by do |match|
      Date.parse(match.dig("fixture", "date"))
    end
    @errors = result["errors"] if result["errors"].present?
  end

  def results
    @league_id = params[:league_id] || 39

    result = @api_service.fixtures(
      league_id: @league_id,
      season: current_season,
      status: "FT"
    )

    @matches = (result["response"] || []).last(20).reverse
    @errors = result["errors"] if result["errors"].present?
  end

  def live
    result = @api_service.live_fixtures

    @matches = result["response"] || []
    @errors = result["errors"] if result["errors"].present?
  end

  def standings
    @league_id = params[:league_id] || 39

    result = @api_service.standings(
      league_id: @league_id,
      season: current_season
    )

    standings_data = result.dig("response", 0, "league", "standings", 0)
    @standings = standings_data || []
    @league_info = result.dig("response", 0, "league")
    @errors = result["errors"] if result["errors"].present?
  end

  private

  def set_api_service
    @api_service = FootballApiService.new
  end

  def set_dummy_mode_notice
    @using_dummy_data = @api_service.using_dummy_data?
  end

  def current_season
    # API-Football無料プランは2022-2024シーズンのみアクセス可能
    # 有料プランに変更した場合は下記のコメントアウトを解除
    # today = Date.today
    # today.month >= 7 ? today.year : today.year - 1
    2024
  end
end
