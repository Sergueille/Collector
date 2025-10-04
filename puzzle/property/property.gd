class_name TileProperty
extends Node

# there are three things now that can trigger a tile property:
# 1. player movement
# 2. power activation
# 3. tile activation
# for the time being let's leave that for the player or the level to
# manage. After we can add a way
# to flexibilize activation triggers (basically leave that to the triggers themselves)

# TODO elaborate a Rulebook solution

func apply():
	_apply()


func _apply():
	push_warning("not implemented!!!")
	return


static func get_tile(property: Node) -> Tile:
	var parent = property.get_parent()
	while parent != null:
		if parent is Tile:
			return parent
		parent = parent.get_parent()
	return null
