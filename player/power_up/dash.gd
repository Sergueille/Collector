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
	
	while puzzle.tiles.has(next):
		# NOT FINISHED : we have to stock the power up in the inventory
		puzzle.tiles[next].set_activated(true)
		player.current_position = next
		player.snap()
		next += dash_direction
