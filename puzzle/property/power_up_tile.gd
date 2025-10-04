class_name PowerUpProperty
extends TileProperty

# this tile gives the player a power-up

var power_up: PackedScene

func _apply():
	var player = Puzzle.get_puzzle(self).player
	player.add_power_up()
	queue_free()
