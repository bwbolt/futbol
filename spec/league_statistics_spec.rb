require './lib/team_stats'
require './lib/game_teams'
require './modules/league_statistics'
require './lib/stat_tracker'
require 'rspec'

describe LeagueStats do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it 'can access TeamStats to count teams' do
  expect(@stat_tracker.count_of_teams).to eq(32)
  end
end