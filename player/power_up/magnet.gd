class_name Magnet
extends PowerUp

# Ce power-up active toutes les tiles autour du joueur (8 directions)
@export var type: Globals.PowerUp = Globals.PowerUp.MAGNET

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
			if puzzle.tiles[pos].has_collectible and not puzzle.tiles[pos].collected:
				var t := create_tween()
				t.tween_property(puzzle.tiles[pos].collectible_sprite, "global_position", player.position, 0.4).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
				
			puzzle.tiles[pos].apply_properties()
			puzzle.tiles[pos].collect_collectible(false)
			
	# NOT FINISHED : we have to check on the offsts tiles if there are any power up
