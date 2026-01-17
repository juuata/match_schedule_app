class LeaguesController < ApplicationController
  POPULAR_LEAGUES = [
    { id: 39, name: "Premier League", country: "England", logo: "https://media.api-sports.io/football/leagues/39.png" },
    { id: 140, name: "La Liga", country: "Spain", logo: "https://media.api-sports.io/football/leagues/140.png" },
    { id: 135, name: "Serie A", country: "Italy", logo: "https://media.api-sports.io/football/leagues/135.png" },
    { id: 78, name: "Bundesliga", country: "Germany", logo: "https://media.api-sports.io/football/leagues/78.png" },
    { id: 61, name: "Ligue 1", country: "France", logo: "https://media.api-sports.io/football/leagues/61.png" },
    { id: 98, name: "J1 League", country: "Japan", logo: "https://media.api-sports.io/football/leagues/98.png" },
    { id: 2, name: "UEFA Champions League", country: "World", logo: "https://media.api-sports.io/football/leagues/2.png" },
    { id: 3, name: "UEFA Europa League", country: "World", logo: "https://media.api-sports.io/football/leagues/3.png" }
  ].freeze

  def index
    @leagues = POPULAR_LEAGUES
  end
end
