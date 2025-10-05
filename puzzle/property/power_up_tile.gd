class_name PowerUpProperty
extends TileProperty

# this tile gives the player a power-up

@export var power_up: Globals.PowerUp

var already_picked_up := false

func _apply():
	if already_picked_up:
		return
	
	var player = Puzzle.get_puzzle(self).player
	player.add_power_up(power_up)
	already_picked_up = true
	# queue_free()
