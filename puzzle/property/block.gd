class_name BlockProperty
extends TileProperty

# this tile blocks movement

func _apply():
	var puzzle = Puzzle.get_puzzle(self)
	if puzzle == null:
		return
	var player = puzzle.player
	var next_player_position = player.current_position + player.movement_direction
	
	if next_player_position == get_tile(self).tile_position:
		player.movement_direction = Vector2i.ZERO
