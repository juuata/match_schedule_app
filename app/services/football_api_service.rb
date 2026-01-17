class FootballApiService
  BASE_URL = "https://v3.football.api-sports.io"

  def initialize
    @api_key = ENV["FOOTBALL_API_KEY"]
  end

  def leagues(country: nil, season: nil)
    params = {}
    params[:country] = country if country
    params[:season] = season if season
    get("/leagues", params)
  end

  def fixtures(league_id:, season:, date: nil, from: nil, to: nil, status: nil)
    params = { league: league_id, season: season }
    params[:date] = date if date
    params[:from] = from if from
    params[:to] = to if to
    params[:status] = status if status
    get("/fixtures", params)
  end

  def fixture(fixture_id)
    get("/fixtures", { id: fixture_id })
  end

  def standings(league_id:, season:)
    get("/standings", { league: league_id, season: season })
  end

  def live_fixtures(league_id: nil)
    params = { live: "all" }
    params[:league] = league_id if league_id
    get("/fixtures", params)
  end

  private

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
