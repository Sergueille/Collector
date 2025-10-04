class_name Magnet
extends PowerUp

# Ce power-up active toutes les tiles autour du joueur (8 directions)
func activate() -> void:
	var puzzle := Puzzle.get_puzzle(self)
	if puzzle == null:
		return
	
	var player := puzzle.player
	if player == null:
		return
	
	var center := player.current_position
	
	var offsets := [
		Vector2i(-1, -1), Vector2i(0, -1), Vector2i(1, -1),
		Vector2i(-1, 0),                     Vector2i(1, 0),
		Vector2i(-1, 1),  Vector2i(0, 1),  Vector2i(1, 1)
	]
	
	for offset in offsets:
		var pos: Vector2i = center + offset
		if puzzle.tiles.has(pos):
			puzzle.tiles[pos].set_activated(true)
			
	# NOT FINISHED : we have to check on the offsts tiles if there are any power up
