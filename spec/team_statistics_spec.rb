# require 'simplecov'
# SimpleCov.start
require './lib/stat_tracker'
require './lib/team'
require './modules/team_statistics'

describe TeamStatistics do
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

  it 'can create a list of Team Stats' do
    expect(@stat_tracker.teams.all? { |team| team.instance_of?(Team) }).to eq(true)
  end

  it 'can return a hash of a teams info' do
    expected = {
      'team_id' => '1',
      'franchise_id' => '23',
      'team_name' => 'Atlanta United',
      'abbreviation' => 'ATL',
      'link' => '/api/v1/teams/1'
    }

    expect(@stat_tracker.team_info('1')).to eq expected
  end

  it 'can produce best season for a team' do
    expect(@stat_tracker.best_season('6')).to eq '20132014'
  end

  it 'can produce worst season for a team' do
    expect(@stat_tracker.worst_season('6')).to eq '20142015'
  end

  it 'can produce average win percentage of a team' do
    expect(@stat_tracker.average_win_percentage('6')).to eq 0.49
  end

  it 'can produce the highest amount of goals of a single game for a team' do
    expect(@stat_tracker.most_goals_scored('18')).to eq 7
  end

  it 'can produce the fewest amount of goals of a single game for a team' do
    expect(@stat_tracker.fewest_goals_scored('18')).to eq 0
  end

  it 'can produce the team that wins against a team the least' do
    expect(@stat_tracker.favorite_opponent('18')).to eq 'DC United'
  end

  it 'can produce the team that wins against a team the most' do
    expect(@stat_tracker.rival('18')).to eq('Houston Dash').or(eq('LA Galaxy'))
  end

  it "can count wins by season" do
    expect(@stat_tracker.count_season_wins('1')).to eq({
       "2012" => 16,
       "2013" => 31,
       "2014" => 28,
       "2015" => 32,
       "2016" => 26,
       "2017" => 33,})
  end

  it "can test the opponenet hasher" do
    expect(@stat_tracker.opponent_hasher('2', 'WIN')).to eq({
       "1" => 12,
       "10" => 6,
       "12" => 8,
       "13" => 7,
       "14" => 5,
       "15" => 12,
       "16" => 3,
       "17" => 7,
       "18" => 4,
       "19" => 4,
       "20" => 7,
       "21" => 4,
       "22" => 4,
       "23" => 4,
       "24" => 4,
       "25" => 5,
       "26" => 1,
       "27" => 1,
       "28" => 3,
       "29" => 6,
       "3" => 10,
       "30" => 3,
       "4" => 6,
       "5" => 10,
       "52" => 6,
       "53" => 4,
       "54" => 2,
       "6" => 4,
       "7" => 10,
       "8" => 5,
       "9" => 6})
  end

  it "can check win ratio hasher" do
    expect(@stat_tracker.win_ratio_hasher('1')).to be_an(Array)
  end
end
