class_name PowerUpProperty
extends TileProperty

# this tile gives the player a power-up

@export var power_up: Globals.PowerUp

var already_picked_up := false

func _ready() -> void:
	$Sprite2D.initial_position = (Vector2(get_tile(self).tile_position) + Vector2(0.5, 0.5)) * Globals.TILE_SIZE

func _apply():
	if already_picked_up:
		return
	
	var player = Puzzle.get_puzzle(self).player
	player.add_power_up(power_up)
	already_picked_up = true
	
	$Sprite2D.visible = false
	
	# queue_free()
