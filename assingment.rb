def create_grid grid_number, ship_positions
  grids = Array.new(grid_number) {Array.new(grid_number,'_')}
  ship_positions.each do|ship_position|
    x,y=ship_position.split(",").map(&:to_i)
    grids[x][y] = 'B'
  end
  return grids
end

def do_battel defender, missile_moves
  missile_moves.each do|missile_move|
    x,y=missile_move.split(",").map(&:to_i)
    defender[x][y] = defender[x][y] == 'B' ?  'X' : 'O'
  end
  defender
end

def count_hits player_grid, player_ship_positions
  hits = 0
  player_ship_positions.each do|player_ship_position|
    x,y=player_ship_position.split(",").map(&:to_i)
    hits += 1 if player_grid[x][y] == 'X' 
  end
  hits
end


def read_file file_path
  file  = File.open(file_path)
  file_data = file.readlines.map(&:chomp)
  file.close
  file_data
end

def write_output_in_file player_grids, number
  open('output.out', 'a') { |file|
    file.puts "Player #{number} grids"
    player_grids.each do|grid|
      file << ("\n")
      file << grid
    end
    file << ("\n")
    file << ("\n")
  }
end

def write_result_in_file(player_1_hits, player_2_hits)
  open('output.out', 'a') { |file|
    file.puts "Player1 hits: #{player_1_hits}"
    file.puts "Player1 hits: #{player_2_hits}"
    return file.puts "It is Draw" if player_1_hits == player_2_hits

    if player_1_hits > player_2_hits
      file.puts "Player 1 win"
    else
      file.puts "player 2 win"
    end
  }
end

file_data  = read_file('./input_file.txt')

grid_number = file_data[0].to_i

player_1_ship_positions = file_data[2].split(":") 
player_2_ship_positions = file_data[3].split(":")

player_1_missile_moves = file_data[5].split(":")
player_2_missile_moves = file_data[6].split(":")


player_1_grids = create_grid grid_number, player_1_ship_positions
player_2_grids = create_grid grid_number, player_2_ship_positions

player_1_grids = do_battel player_1_grids, player_2_missile_moves
player_2_grids = do_battel player_2_grids, player_1_missile_moves


player_1_hits = count_hits player_1_grids, player_1_ship_positions
player_2_hits = count_hits player_2_grids, player_2_ship_positions

write_output_in_file(player_1_grids,1)
write_output_in_file(player_2_grids,2)
write_result_in_file(player_1_hits, player_2_hits)





