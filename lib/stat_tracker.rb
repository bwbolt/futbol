require 'csv'
require_relative 'team'
require_relative '../modules/game_statistics'
require_relative '../modules/league_statistics'
require_relative '../modules/season_statistics'
require_relative '../modules/team_statistics'

class StatTracker < Team
  include TeamStatistics
  include GameStats
  include LeagueStats
  include Season

  attr_accessor :games, :teams, :game_teams, :games_csv, :teams_csv, :game_teams_csv

  def initialize(locations)
    @games_csv = CSV.read(locations[:games], headers: true)
    @teams_csv = CSV.read(locations[:teams], headers: true)
    @game_teams_csv = CSV.read(locations[:game_teams], headers: true)
    @games = nil
    @teams = nil
    @game_teams = nil
  end

  def self.from_csv(locations)
    stat_tracker = StatTracker.new(locations)
    stat_tracker.games = Game.create_list_of_games(stat_tracker.games_csv)
    stat_tracker.teams = Team.create_list_of_teams(stat_tracker.teams_csv)
    stat_tracker.game_teams = GameTeams.create_list_of_game_teams(stat_tracker.game_teams_csv)
    stat_tracker
  end
end
