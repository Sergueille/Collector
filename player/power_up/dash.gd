class_name Dash
extends PowerUp


@export var type: Globals.PowerUp = Globals.PowerUp.DASH

var dash_direction: Vector2i = Vector2i.ZERO

# this power-up makes the player move until it hits a wall
# All crossed squares are activated and power ups are stored.
func activate() -> void:
	var puzzle := Puzzle.get_puzzle(self)
	if puzzle == null:
		return
	
	var player := puzzle.player
	if player == null:
		return
	
	var current := player.current_position
	var next := current + dash_direction
	
	# BUG player can dash through tiles with block property
	while puzzle.tiles.has(next):
		player.target_position = next
		puzzle.tiles[next].apply_properties()
		puzzle.tiles[next].collect_collectible() 
		
		if player.target_position == player.current_position:
			break
		
		#puzzle.tiles[next].collect_collectible()
		player.current_position = next
		player.snap()
		next += dash_direction
