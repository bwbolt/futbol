# require 'simplecov'
# SimpleCov.start
require 'rspec'
require './modules/season_statistics'
require './lib/stat_tracker'
require 'pry'

RSpec.describe 'Season' do
  before(:each) do
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

  describe 'behavior' do
    it 'returns winningest coach' do
      expect(@stat_tracker.winningest_coach('20132014')).to eq 'Claude Julien'
      expect(@stat_tracker.winningest_coach('20142015')).to eq 'Alain Vigneault'
    end

    it 'returns worst coach' do
      expect(@stat_tracker.worst_coach('20132014')).to eq 'Peter Laviolette'
      expect(@stat_tracker.worst_coach('20142015')).to eq 'Craig MacTavish'
    end

    it ' returns the most accurate team' do
      expect(@stat_tracker.most_accurate_team('20132014')).to eq 'Real Salt Lake'
      expect(@stat_tracker.most_accurate_team('20142015')).to eq 'Toronto FC'
    end

    it 'returns the least accurate team' do
      expect(@stat_tracker.least_accurate_team('20132014')).to eq 'New York City FC'
      expect(@stat_tracker.least_accurate_team('20142015')).to eq 'Columbus Crew SC'
    end

    it 'returns team with most tackles' do
      expect(@stat_tracker.most_tackles('20132014')).to eq 'FC Cincinnati'
      expect(@stat_tracker.most_tackles('20142015')).to eq 'Seattle Sounders FC'
    end

    it 'returns team with least tackles' do
      expect(@stat_tracker.fewest_tackles('20132014')).to eq 'Atlanta United'
    end

    it 'returns team accuracy' do
      expect(@stat_tracker.team_accuracy('20132014')).to eq [['9', 0.263889],
                                                             ['13', 0.264151],
                                                             ['23', 0.266556],
                                                             ['7', 0.268245],
                                                             ['3', 0.270073],
                                                             ['12', 0.273322],
                                                             ['28', 0.273954],
                                                             ['15', 0.281961],
                                                             ['26', 0.283272],
                                                             ['17', 0.287805],
                                                             ['27', 0.289076],
                                                             ['4', 0.292259],
                                                             ['18', 0.293805],
                                                             ['52', 0.294118],
                                                             ['2', 0.294702],
                                                             ['8', 0.296852],
                                                             ['22', 0.298077],
                                                             ['25', 0.300151],
                                                             ['29', 0.300319],
                                                             ['30', 0.30363],
                                                             ['5', 0.303779],
                                                             ['16', 0.304236],
                                                             ['1', 0.306043],
                                                             ['6', 0.306407],
                                                             ['14', 0.307692],
                                                             ['19', 0.31129],
                                                             ['10', 0.313076],
                                                             ['21', 0.314845],
                                                             ['20', 0.316602],
                                                             ['24', 0.334776]]
    end

    it 'returns team tackles' do
      expect(@stat_tracker.team_tackles('20132014')).to eq [['1', 1568],
                                                            ['18', 1611],
                                                            ['20', 1708],
                                                            ['23', 1710],
                                                            ['22', 1751],
                                                            ['14', 1774],
                                                            ['17', 1783],
                                                            ['30', 1787],
                                                            ['12', 1807],
                                                            ['25', 1820],
                                                            ['16', 1836],
                                                            ['13', 1860],
                                                            ['15', 1904],
                                                            ['28', 1931],
                                                            ['7', 1992],
                                                            ['19', 2087],
                                                            ['2', 2092],
                                                            ['27', 2173],
                                                            ['8', 2211],
                                                            ['21', 2223],
                                                            ['52', 2313],
                                                            ['9', 2351],
                                                            ['4', 2404],
                                                            ['6', 2441],
                                                            ['5', 2510],
                                                            ['24', 2515],
                                                            ['10', 2592],
                                                            ['3', 2675],
                                                            ['29', 2915],
                                                            ['26', 3691]]
    end

    it 'returns coach performance' do
      expect(@stat_tracker.coach_record('20132014', 'WIN')).to eq [['Ron Rolston', 2],
                                                                   ['Kevin Dineen', 3],
                                                                   ['Paul Maurice', 12],
                                                                   ['Claude Noel', 13],
                                                                   ['Ted Nolan', 13],
                                                                   ['Peter Horachek', 15],
                                                                   ['Dallas Eakins', 19],
                                                                   ['Randy Carlyle', 22],
                                                                   ['Adam Oates', 22],
                                                                   ['Jack Capuano', 22],
                                                                   ['Bob Hartley', 24],
                                                                   ['Paul MacLean', 24],
                                                                   ['Dave Tippett', 28],
                                                                   ['Jon Cooper', 29],
                                                                   ['Peter DeBoer', 31],
                                                                   ['Barry Trotz', 31],
                                                                   ['Mike Babcock', 31],
                                                                   ['Kirk Muller', 31],
                                                                   ['John Tortorella', 33],
                                                                   ['Craig Berube', 34],
                                                                   ['Lindy Ruff', 34],
                                                                   ['Patrick Roy', 36],
                                                                   ['Mike Yeo', 37],
                                                                   ['Ken Hitchcock', 37],
                                                                   ['Todd Richards', 38],
                                                                   ['Todd McLellan', 41],
                                                                   ['Michel Therrien', 44],
                                                                   ['Dan Bylsma', 46],
                                                                   ['Joel Quenneville', 47],
                                                                   ['Bruce Boudreau', 49],
                                                                   ['Alain Vigneault', 49],
                                                                   ['Darryl Sutter', 53],
                                                                   ['Claude Julien', 54]]
    end
  end
end
