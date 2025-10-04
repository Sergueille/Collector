class_name BlockProperty
extends TileProperty

# this tile blocks movement

func _apply():
	var puzzle = Puzzle.get_puzzle(self)
	if puzzle == null:
		return
	var player = puzzle.player
	if player.target_position == puzzle.tiles.find_key(get_tile(self)):
		player.target_position = player.current_position
