require './lib/stat_tracker'
require 'erb'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}
@stat_tracker = StatTracker.from_csv(locations)

# render template
template = File.read('./site/template.html.erb')
result = ERB.new(template).result(binding)

# write result to file
File.open('./site/filename.html', 'w+') do |f|
  f.write result
end
