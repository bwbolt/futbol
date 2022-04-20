# require 'simplecov'
# SimpleCov.start
require './lib/game'
require './lib/game_teams'
require './modules/game_statistics'
require './lib/stat_tracker'
require 'rspec'

describe GameStats do
  before(:each) do
    game_path = './data/game_stub.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_team_stub.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it "#highest_total_score" do
   expect(@stat_tracker.highest_total_score).to eq 5
  end
 
  it '#lowest_total_score' do
    expect(@stat_tracker.lowest_total_score).to eq 1
  end

  it '#percentage_home_wins' do
    expect(@stat_tracker.percentage_home_wins).to eq 0.72
  end

  it '#percentage_visitor_wins' do
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.24
  end

  it '#percentage_ties' do
    expect(@stat_tracker.percentage_ties).to eq 0.03
  end

  it '#count_of_games_by_season' do
    expect(@stat_tracker.count_of_games_by_season).to eq({
                                                           '20122013' => 29
                                                         })
  end

  it '#average_goals_per_game' do
    expect(@stat_tracker.average_goals_per_game).to eq 3.69
  end

  it '#average_goals_by_season' do
    expect(@stat_tracker.average_goals_by_season).to eq({
                                                          '20122013' => 3.69
                                                        })
  end
end
