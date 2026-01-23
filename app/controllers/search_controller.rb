class SearchController < ApplicationController
  def index
    @query = params[:q].to_s.strip
    @leagues = []
    @teams = []

    # キーワード検索
    if @query.present?
      @leagues = search_leagues(@query)
      @teams = search_teams(@query)
    end

    # ドロップダウン検索用データ
    @all_leagues = DummyDataService::LEAGUES.values
    @selected_league_id = params[:league_id].to_i if params[:league_id].present?
    @selected_team_id = params[:team_id].to_i if params[:team_id].present?

    # リーグ選択時のチーム一覧
    @league_teams = []
    if @selected_league_id
      @league_teams = DummyDataService::TEAMS[@selected_league_id] || []
    end

    # チーム選択時の結果
    if @selected_team_id && @selected_league_id
      @selected_team = @league_teams.find { |t| t[:id] == @selected_team_id }
      @selected_league = DummyDataService::LEAGUES[@selected_league_id]
    end
  end

  def teams_for_league
    league_id = params[:league_id].to_i
    teams = DummyDataService::TEAMS[league_id] || []
    render json: teams.map { |t| { id: t[:id], name: t[:name], name_ja: t[:name_ja] } }
  end

  private

  def search_leagues(query)
    query_downcase = query.downcase
    DummyDataService::LEAGUES.values.select do |league|
      league[:name].downcase.include?(query_downcase) ||
        league[:country].downcase.include?(query_downcase) ||
        league[:name_ja]&.include?(query) ||
        league[:country_ja]&.include?(query)
    end
  end

  def search_teams(query)
    query_downcase = query.downcase
    results = []

    DummyDataService::TEAMS.each do |league_id, teams|
      league = DummyDataService::LEAGUES[league_id]
      teams.each do |team|
        if team[:name].downcase.include?(query_downcase) || team[:name_ja]&.include?(query)
          results << team.merge(league: league)
        end
      end
    end

    results.uniq { |t| t[:id] }
  end
end
