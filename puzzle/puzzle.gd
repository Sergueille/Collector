class_name Puzzle
extends Node2D

@export var player: Player
@export var tiles: Dictionary[Vector2i, Tile] # position of the tile - tile
@export var tilemap: TileMapLayer
@export var ui: Control


func _ready() -> void:
	set_level()


func set_level():
	# TODO create tiles and add them to tilemap
	for item in ui.items:
		item.set_use_count(player.power_ups[item.type])
	return


static func get_puzzle(node: Node) -> Puzzle:
	var parent := node.get_parent()

	while parent != null and not (parent is Puzzle):
		parent = parent.get_parent()

	return parent if parent != null else null


func _on_power_up_obtained(power_up: Globals.PowerUp) -> void:
	ui.items.filter(func(x): return x.type == power_up)[0]\
		.set_use_count(player.power_ups[power_up])


func _on_power_up_used(power_up: Globals.PowerUp) -> void:
	ui.items.filter(func(x): return x.type == power_up)[0]\
		.set_use_count(player.power_ups[power_up])
