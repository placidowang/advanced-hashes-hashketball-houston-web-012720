require 'pp'

def game_hash
  {home:
    {team_name: "Brooklyn Nets",
    colors: ["Black", "White"],
    players:
      [{player_name: "Alan Anderson",
        number: 0,
        shoe: 16,
        points: 22,
        rebounds: 12,
        assists: 12,
        steals: 3,
        blocks: 1,
        slam_dunks: 1},
        {player_name: "Reggie Evans",
        number: 30,
        shoe: 14,
        points: 12,
        rebounds: 12,
        assists: 12,
        steals: 12,
        blocks: 12,
        slam_dunks: 7},
        {player_name: "Brook Lopez",
        number: 11,
        shoe: 17,
        points: 17,
        rebounds: 19,
        assists: 10,
        steals: 3,
        blocks: 1,
        slam_dunks: 15},
        {player_name: "Mason Plumlee",
        number: 1,
        shoe: 19,
        points: 26,
        rebounds: 11,
        assists: 6,
        steals: 3,
        blocks: 8,
        slam_dunks: 5},
        {player_name: "Jason Terry",
        number: 31,
        shoe: 15,
        points: 19,
        rebounds: 2,
        assists: 2,
        steals: 4,
        blocks: 11,
        slam_dunks: 1}]},
    
    away:
      {team_name: "Charlotte Hornets",
      colors: ["Turquoise", "Purple"],
      players:
      [{player_name: "Jeff Adrien",
        number: 4,
        shoe: 18,
        points: 10,
        rebounds: 1,
        assists: 1,
        steals: 2,
        blocks: 7,
        slam_dunks: 2},
        {player_name: "Bismack Biyombo",
        number: 0,
        shoe: 16,
        points: 12,
        rebounds: 4,
        assists: 7,
        steals: 22,
        blocks: 15,
        slam_dunks: 10},
        {player_name: "DeSagna Diop",
        number: 2,
        shoe: 14,
        points: 24,
        rebounds: 12,
        assists: 12,
        steals: 4,
        blocks: 5,
        slam_dunks: 5},
        {player_name: "Ben Gordon",
        number: 8,
        shoe: 15,
        points: 33,
        rebounds: 3,
        assists: 2,
        steals: 1,
        blocks: 1,
        slam_dunks: 0},
        {player_name: "Kemba Walker",
        number: 33,
        shoe: 15,
        points: 6,
        rebounds: 12,
        assists: 12,
        steals: 7,
        blocks: 5,
        slam_dunks: 12}]}}
end

def consolidated_players
  consolidated_players = []
  game_hash.each_value do |team_data| 
    consolidated_players << team_data[:players]
  end
  return consolidated_players.flatten
end

def player_stats(player_name)
  player_stats = consolidated_players.reduce(nil) {|memo, player| player[:player_name] === player_name ? player : memo }
  
  if player_stats
    player_stats.shift
    return player_stats
  end
  
  nil
end


def num_points_scored(player_name)
  player_stats(player_name)[:points]
end

def shoe_size(player_name)
  player_stats(player_name)[:shoe]
end

def team_colors(team_name)
  game_hash.each_value do |team_data|
    return team_data[:colors] if team_data[:team_name] === team_name
  end
end

def team_names
  game_hash.reduce([]) do |memo, (team, team_data)| 
    memo << team_data[:team_name]
  end
end

def player_numbers(team_name)
  game_hash.each_value do |team_data| 
    if team_data[:team_name] === team_name
      return team_data[:players].reduce([]) do |memo, player| 
        memo << player[:number]
      end
    end
  end
end

def consolidated_players
  consolidated_players = []
  game_hash.each_value do |team_data| 
    consolidated_players << team_data[:players]
  end
  return consolidated_players.flatten
end

def big_shoe_rebounds
  player_with_largest_shoe = consolidated_players.reduce(consolidated_players[0]) { |memo, player| memo[:shoe] > player[:shoe] ? memo : player}
  
  return player_with_largest_shoe[:rebounds]
end

def most_points_scored
  highest_scoring_player = consolidated_players.reduce(consolidated_players[0]) { |memo, player| player[:points] > memo[:points] ? player: memo }
  
  return highest_scoring_player[:player_name]
end

def winning_team
  home_team_points = game_hash[:home][:players].reduce(0) { |memo, player| memo + player[:points]}
  
  away_team_points = game_hash[:away][:players].reduce(0) { |memo, player| memo + player[:points]}
  
  return home_team_points > away_team_points ? game_hash[:home][:team_name] : game_hash[:away][:team_name]
end

def player_with_longest_name
  player_names = consolidated_players.reduce([]) { |memo, player| memo << player[:player_name] }
  
  return player_names.max_by { |name| name.length }
  # return player_name.reduce("") { |memo, name| memo.length > name.length ? memo : name }
end

def player_with_most_steals
  player_with_most_steals = consolidated_players.reduce(consolidated_players[0]) { |memo, player| player[:steals] > memo[:steals] ? player : memo}
  
  return player_with_most_steals[:player_name]
end

def long_name_steals_a_ton? 
  player_with_most_steals === player_with_longest_name
end
