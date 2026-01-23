class DummyDataService
  TEAMS = {
    # Premier League
    39 => [
      { id: 33, name: "Manchester United", name_ja: "マンチェスター・ユナイテッド", logo: "https://media.api-sports.io/football/teams/33.png" },
      { id: 34, name: "Newcastle", name_ja: "ニューカッスル", logo: "https://media.api-sports.io/football/teams/34.png" },
      { id: 40, name: "Liverpool", name_ja: "リバプール", logo: "https://media.api-sports.io/football/teams/40.png" },
      { id: 42, name: "Arsenal", name_ja: "アーセナル", logo: "https://media.api-sports.io/football/teams/42.png" },
      { id: 49, name: "Chelsea", name_ja: "チェルシー", logo: "https://media.api-sports.io/football/teams/49.png" },
      { id: 50, name: "Manchester City", name_ja: "マンチェスター・シティ", logo: "https://media.api-sports.io/football/teams/50.png" },
      { id: 47, name: "Tottenham", name_ja: "トッテナム", logo: "https://media.api-sports.io/football/teams/47.png" },
      { id: 66, name: "Aston Villa", name_ja: "アストン・ヴィラ", logo: "https://media.api-sports.io/football/teams/66.png" }
    ],
    # La Liga
    140 => [
      { id: 529, name: "Barcelona", name_ja: "バルセロナ", logo: "https://media.api-sports.io/football/teams/529.png" },
      { id: 541, name: "Real Madrid", name_ja: "レアル・マドリード", logo: "https://media.api-sports.io/football/teams/541.png" },
      { id: 530, name: "Atletico Madrid", name_ja: "アトレティコ・マドリード", logo: "https://media.api-sports.io/football/teams/530.png" },
      { id: 536, name: "Sevilla", name_ja: "セビージャ", logo: "https://media.api-sports.io/football/teams/536.png" }
    ],
    # Serie A
    135 => [
      { id: 489, name: "AC Milan", name_ja: "ACミラン", logo: "https://media.api-sports.io/football/teams/489.png" },
      { id: 496, name: "Juventus", name_ja: "ユベントス", logo: "https://media.api-sports.io/football/teams/496.png" },
      { id: 505, name: "Inter", name_ja: "インテル", logo: "https://media.api-sports.io/football/teams/505.png" },
      { id: 492, name: "Napoli", name_ja: "ナポリ", logo: "https://media.api-sports.io/football/teams/492.png" }
    ],
    # Bundesliga
    78 => [
      { id: 157, name: "Bayern Munich", name_ja: "バイエルン・ミュンヘン", logo: "https://media.api-sports.io/football/teams/157.png" },
      { id: 165, name: "Borussia Dortmund", name_ja: "ボルシア・ドルトムント", logo: "https://media.api-sports.io/football/teams/165.png" },
      { id: 173, name: "RB Leipzig", name_ja: "RBライプツィヒ", logo: "https://media.api-sports.io/football/teams/173.png" },
      { id: 168, name: "Bayer Leverkusen", name_ja: "バイヤー・レバークーゼン", logo: "https://media.api-sports.io/football/teams/168.png" }
    ],
    # Ligue 1
    61 => [
      { id: 85, name: "Paris Saint Germain", name_ja: "パリ・サンジェルマン", logo: "https://media.api-sports.io/football/teams/85.png" },
      { id: 81, name: "Marseille", name_ja: "マルセイユ", logo: "https://media.api-sports.io/football/teams/81.png" },
      { id: 80, name: "Lyon", name_ja: "リヨン", logo: "https://media.api-sports.io/football/teams/80.png" },
      { id: 91, name: "Monaco", name_ja: "モナコ", logo: "https://media.api-sports.io/football/teams/91.png" }
    ],
    # J1 League
    98 => [
      { id: 295, name: "Vissel Kobe", name_ja: "ヴィッセル神戸", logo: "https://media.api-sports.io/football/teams/295.png" },
      { id: 286, name: "Yokohama F. Marinos", name_ja: "横浜F・マリノス", logo: "https://media.api-sports.io/football/teams/286.png" },
      { id: 284, name: "Urawa Red Diamonds", name_ja: "浦和レッズ", logo: "https://media.api-sports.io/football/teams/284.png" },
      { id: 289, name: "Kawasaki Frontale", name_ja: "川崎フロンターレ", logo: "https://media.api-sports.io/football/teams/289.png" }
    ],
    # Champions League
    2 => [
      { id: 50, name: "Manchester City", name_ja: "マンチェスター・シティ", logo: "https://media.api-sports.io/football/teams/50.png" },
      { id: 541, name: "Real Madrid", name_ja: "レアル・マドリード", logo: "https://media.api-sports.io/football/teams/541.png" },
      { id: 157, name: "Bayern Munich", name_ja: "バイエルン・ミュンヘン", logo: "https://media.api-sports.io/football/teams/157.png" },
      { id: 85, name: "Paris Saint Germain", name_ja: "パリ・サンジェルマン", logo: "https://media.api-sports.io/football/teams/85.png" }
    ],
    # Europa League
    3 => [
      { id: 40, name: "Liverpool", name_ja: "リバプール", logo: "https://media.api-sports.io/football/teams/40.png" },
      { id: 530, name: "Atletico Madrid", name_ja: "アトレティコ・マドリード", logo: "https://media.api-sports.io/football/teams/530.png" },
      { id: 496, name: "Juventus", name_ja: "ユベントス", logo: "https://media.api-sports.io/football/teams/496.png" },
      { id: 165, name: "Borussia Dortmund", name_ja: "ボルシア・ドルトムント", logo: "https://media.api-sports.io/football/teams/165.png" }
    ]
  }.freeze

  LEAGUES = {
    39 => { id: 39, name: "Premier League", name_ja: "プレミアリーグ", country: "England", country_ja: "イングランド", logo: "https://media.api-sports.io/football/leagues/39.png" },
    140 => { id: 140, name: "La Liga", name_ja: "ラ・リーガ", country: "Spain", country_ja: "スペイン", logo: "https://media.api-sports.io/football/leagues/140.png" },
    135 => { id: 135, name: "Serie A", name_ja: "セリエA", country: "Italy", country_ja: "イタリア", logo: "https://media.api-sports.io/football/leagues/135.png" },
    78 => { id: 78, name: "Bundesliga", name_ja: "ブンデスリーガ", country: "Germany", country_ja: "ドイツ", logo: "https://media.api-sports.io/football/leagues/78.png" },
    61 => { id: 61, name: "Ligue 1", name_ja: "リーグ・アン", country: "France", country_ja: "フランス", logo: "https://media.api-sports.io/football/leagues/61.png" },
    98 => { id: 98, name: "J1 League", name_ja: "J1リーグ", country: "Japan", country_ja: "日本", logo: "https://media.api-sports.io/football/leagues/98.png" },
    2 => { id: 2, name: "UEFA Champions League", name_ja: "UEFAチャンピオンズリーグ", country: "World", country_ja: "世界", logo: "https://media.api-sports.io/football/leagues/2.png" },
    3 => { id: 3, name: "UEFA Europa League", name_ja: "UEFAヨーロッパリーグ", country: "World", country_ja: "世界", logo: "https://media.api-sports.io/football/leagues/3.png" }
  }.freeze

  def initialize
    @fixture_id_counter = 1000
  end

  def fixtures(league_id:, season:, date: nil, from: nil, to: nil, status: nil)
    league_id = league_id.to_i
    teams = TEAMS[league_id] || TEAMS[39]
    league = LEAGUES[league_id] || LEAGUES[39]

    fixtures = []

    if date
      fixtures = generate_fixtures_for_date(Date.parse(date), teams, league, season)
    elsif from && to
      start_date = Date.parse(from)
      end_date = Date.parse(to)
      (start_date..end_date).each do |d|
        fixtures.concat(generate_fixtures_for_date(d, teams, league, season))
      end
    elsif status == "FT"
      (1..10).each do |i|
        past_date = Date.today - i
        fixtures.concat(generate_finished_fixtures(past_date, teams, league, season))
      end
    else
      fixtures = generate_fixtures_for_date(Date.today, teams, league, season)
    end

    { "response" => fixtures, "errors" => [] }
  end

  def fixture(fixture_id)
    league = LEAGUES[39]
    teams = TEAMS[39]
    home_team = teams[0]
    away_team = teams[1]

    fixture = build_fixture(
      fixture_id: fixture_id.to_i,
      date: Date.today,
      home_team: home_team,
      away_team: away_team,
      league: league,
      season: current_season,
      status: "FT",
      home_goals: 2,
      away_goals: 1
    )

    { "response" => [fixture], "errors" => [] }
  end

  def standings(league_id:, season:)
    league_id = league_id.to_i
    teams = TEAMS[league_id] || TEAMS[39]
    league = LEAGUES[league_id] || LEAGUES[39]

    standings = teams.each_with_index.map do |team, index|
      rank = index + 1
      played = 20 - rank
      wins = [15 - rank, 0].max
      draws = [5 - rank, 0].max
      losses = played - wins - draws
      goals_for = 40 - (rank * 3)
      goals_against = 10 + (rank * 2)

      {
        "rank" => rank,
        "team" => stringify_keys(team),
        "points" => (wins * 3) + draws,
        "goalsDiff" => goals_for - goals_against,
        "form" => generate_form(rank),
        "all" => {
          "played" => played,
          "win" => wins,
          "draw" => draws,
          "lose" => losses,
          "goals" => {
            "for" => goals_for,
            "against" => goals_against
          }
        }
      }
    end

    {
      "response" => [
        {
          "league" => {
            "id" => league[:id],
            "name" => league[:name],
            "country" => league[:country],
            "logo" => league[:logo],
            "season" => season,
            "standings" => [standings]
          }
        }
      ],
      "errors" => []
    }
  end

  def live_fixtures(league_id: nil)
    fixtures = []

    [39, 140, 135].each do |lid|
      next if league_id && league_id.to_i != lid

      teams = TEAMS[lid]
      league = LEAGUES[lid]
      next unless teams && league

      elapsed = rand(1..89)
      fixture = build_fixture(
        fixture_id: next_fixture_id,
        date: Date.today,
        home_team: teams[0],
        away_team: teams[1],
        league: league,
        season: current_season,
        status: elapsed < 45 ? "1H" : "2H",
        elapsed: elapsed,
        home_goals: rand(0..2),
        away_goals: rand(0..2)
      )
      fixtures << fixture
    end

    { "response" => fixtures, "errors" => [] }
  end

  private

  def generate_fixtures_for_date(date, teams, league, season)
    fixtures = []
    shuffled_teams = teams.shuffle

    (shuffled_teams.length / 2).times do |i|
      home_team = shuffled_teams[i * 2]
      away_team = shuffled_teams[i * 2 + 1]
      next unless home_team && away_team

      hour = 14 + (i * 2)
      is_past = date < Date.today || (date == Date.today && Time.now.hour > hour)

      if is_past
        fixture = build_fixture(
          fixture_id: next_fixture_id,
          date: date,
          time: "#{hour}:00",
          home_team: home_team,
          away_team: away_team,
          league: league,
          season: season,
          status: "FT",
          home_goals: rand(0..4),
          away_goals: rand(0..3)
        )
      else
        fixture = build_fixture(
          fixture_id: next_fixture_id,
          date: date,
          time: "#{hour}:00",
          home_team: home_team,
          away_team: away_team,
          league: league,
          season: season,
          status: "NS"
        )
      end

      fixtures << fixture
    end

    fixtures
  end

  def generate_finished_fixtures(date, teams, league, season)
    fixtures = []
    shuffled_teams = teams.shuffle

    2.times do |i|
      home_team = shuffled_teams[i * 2]
      away_team = shuffled_teams[i * 2 + 1]
      next unless home_team && away_team

      fixture = build_fixture(
        fixture_id: next_fixture_id,
        date: date,
        time: "#{15 + i}:00",
        home_team: home_team,
        away_team: away_team,
        league: league,
        season: season,
        status: "FT",
        home_goals: rand(0..4),
        away_goals: rand(0..3)
      )

      fixtures << fixture
    end

    fixtures
  end

  def build_fixture(fixture_id:, date:, home_team:, away_team:, league:, season:, status:, time: "15:00", elapsed: nil, home_goals: nil, away_goals: nil)
    home_goals ||= 0
    away_goals ||= 0
    home_winner = home_goals > away_goals
    away_winner = away_goals > home_goals

    home_team_data = stringify_keys(home_team).merge("winner" => status == "FT" ? home_winner : nil)
    away_team_data = stringify_keys(away_team).merge("winner" => status == "FT" ? away_winner : nil)

    {
      "fixture" => {
        "id" => fixture_id,
        "date" => "#{date}T#{time}:00+00:00",
        "venue" => { "name" => "Stadium", "city" => "City" },
        "status" => {
          "short" => status,
          "elapsed" => elapsed
        },
        "referee" => "John Smith"
      },
      "league" => {
        "id" => league[:id],
        "name" => league[:name],
        "country" => league[:country],
        "logo" => league[:logo],
        "round" => "Regular Season - #{rand(1..38)}"
      },
      "teams" => {
        "home" => home_team_data,
        "away" => away_team_data
      },
      "goals" => {
        "home" => ["FT", "1H", "2H", "HT"].include?(status) ? home_goals : nil,
        "away" => ["FT", "1H", "2H", "HT"].include?(status) ? away_goals : nil
      },
      "score" => {
        "halftime" => { "home" => home_goals > 0 ? rand(0..home_goals) : 0, "away" => away_goals > 0 ? rand(0..away_goals) : 0 },
        "fulltime" => { "home" => home_goals, "away" => away_goals },
        "extratime" => { "home" => nil, "away" => nil },
        "penalty" => { "home" => nil, "away" => nil }
      }
    }
  end

  def generate_form(rank)
    forms = ["W", "D", "L"]
    weights = case rank
              when 1..2 then [0.6, 0.3, 0.1]
              when 3..4 then [0.5, 0.3, 0.2]
              else [0.3, 0.3, 0.4]
              end

    5.times.map { weighted_sample(forms, weights) }.join
  end

  def weighted_sample(items, weights)
    total = weights.sum
    random = rand * total
    cumulative = 0

    items.each_with_index do |item, i|
      cumulative += weights[i]
      return item if random <= cumulative
    end

    items.last
  end

  def next_fixture_id
    @fixture_id_counter += 1
  end

  def current_season
    today = Date.today
    today.month >= 7 ? today.year : today.year - 1
  end

  def stringify_keys(hash)
    hash.transform_keys(&:to_s)
  end
end
