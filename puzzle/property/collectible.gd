class_name CollectibleProperty
extends TileProperty

# this tile has a collectible on it

var collected := false

func _apply():
	var player = Puzzle.get_puzzle(self).player
	queue_free()
