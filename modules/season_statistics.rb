require_relative '../lib/game'
require_relative '../lib/game_teams'
require_relative '../lib/team'

module Season
  def games_by_season(season)
    @game_teams.find_all { |game| game.game_id[0..3] == season[0..3] }
  end

  def coach_record(season, result)
    games = games_by_season(season).find_all { |game| game.result == result }
    coaches = Hash.new(0)
    games.each do |game|
      coaches[game.head_coach] += 1
    end
    coaches.sort_by { |_coach, number| number }
  end

  def winningest_coach(season)
    coach_record(season, 'WIN').last[0]
  end

  def worst_coach(season)
    coach_record(season, 'LOSS').first[0]
  end

  def most_accurate_team(season)
    team_id_to_name(team_accuracy(season).last[0])
  end

  def least_accurate_team(season)
    team_id_to_name(team_accuracy(season).first[0])
  end

  def team_accuracy(season)
    teams = {}
    games_by_season(season).each do |game|
      if teams[game.team_id].nil?
        teams[game.team_id] = { goals: game.goals, shots: game.shots }
      else
        teams[game.team_id][:goals] += game.goals
        teams[game.team_id][:shots] += game.shots
      end
    end
    teams.map { |team, number| [team, (number[:goals].to_f / number[:shots]).round(6)] }.sort_by { |team| team[1] }
  end

  def most_tackles(season)
    team_id_to_name(team_tackles(season).last[0])
  end

  def fewest_tackles(season)
    team_id_to_name(team_tackles(season).first[0])
  end

  def team_tackles(season)
    teams = {}
    games_by_season(season).each do |game|
      if teams[game.team_id].nil?
        teams[game.team_id] = game.tackles
      else
        teams[game.team_id] += game.tackles
      end
    end
    a = teams.sort_by { |_team, number| number }
  end
end
