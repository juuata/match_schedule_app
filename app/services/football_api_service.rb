class FootballApiService
  BASE_URL = "https://v3.football.api-sports.io"

  def initialize
    @api_key = ENV["FOOTBALL_API_KEY"]
    @use_dummy = @api_key.blank? || @api_key == "your_api_key_here"
    @dummy_service = DummyDataService.new if @use_dummy
  end

  def leagues(country: nil, season: nil)
    return dummy_leagues if @use_dummy

    params = {}
    params[:country] = country if country
    params[:season] = season if season
    get("/leagues", params)
  end

  def fixtures(league_id:, season:, date: nil, from: nil, to: nil, status: nil)
    if @use_dummy
      return @dummy_service.fixtures(
        league_id: league_id,
        season: season,
        date: date,
        from: from,
        to: to,
        status: status
      )
    end

    params = { league: league_id, season: season }
    params[:date] = date if date
    params[:from] = from if from
    params[:to] = to if to
    params[:status] = status if status
    get("/fixtures", params)
  end

  def fixture(fixture_id)
    return @dummy_service.fixture(fixture_id) if @use_dummy

    get("/fixtures", { id: fixture_id })
  end

  def standings(league_id:, season:)
    return @dummy_service.standings(league_id: league_id, season: season) if @use_dummy

    get("/standings", { league: league_id, season: season })
  end

  def live_fixtures(league_id: nil)
    return @dummy_service.live_fixtures(league_id: league_id) if @use_dummy

    params = { live: "all" }
    params[:league] = league_id if league_id
    get("/fixtures", params)
  end

  def using_dummy_data?
    @use_dummy
  end

  private

  def dummy_leagues
    {
      "response" => DummyDataService::LEAGUES.values.map do |league|
        { "league" => league }
      end,
      "errors" => []
    }
  end

  def get(endpoint, params = {})
    response = connection.get(endpoint, params)

    if response.success?
      JSON.parse(response.body)
    else
      { "errors" => ["API request failed: #{response.status}"], "response" => [] }
    end
  rescue Faraday::Error => e
    { "errors" => [e.message], "response" => [] }
  end

  def connection
    @connection ||= Faraday.new(url: BASE_URL) do |conn|
      conn.headers["x-apisports-key"] = @api_key
      conn.headers["Content-Type"] = "application/json"
      conn.adapter Faraday.default_adapter
    end
  end
end
