class_name Puzzle
extends Node2D

@export var player: Player
@export var tiles: Dictionary[Vector2i, Tile] # position of the tile - tile
@export var tilemap: TileMapLayer


func set_level():
	# TODO create tiles and add them to tilemap
	return


static func get_puzzle(node: Node) -> Puzzle:
	var parent := node.get_parent()

	while parent != null and not (parent is Puzzle):
		parent = parent.get_parent()

	return parent if parent != null else null
