class_name Puzzle
extends Node2D

@export var player: Player
@export var tiles: Dictionary[Vector2i, Tile] # position of the tile - tile
@export var tilemap: TileMapLayer
@export var ui: Control
@export var tile_scene: PackedScene

@export var move_remaining: int

func _ready() -> void:
	#set_level()
	pass  


func set_level():
	# TODO add tiles in tilemap
	for tile_position in tiles.keys():
		for property_scene in tiles[tile_position].properties:
			tiles[tile_position].add_child(property_scene.instantiate())
			
		if tiles[tile_position].data.has_sprite:
			tilemap.set_cell(tile_position, 0, tiles[tile_position].data.atlas_coordinates)
	for item in ui.items:
		item.set_use_count(player.power_ups[item.type])
	return


static func get_puzzle(node: Node) -> Puzzle:
	var parent := node.get_parent()

	while parent != null and not (parent is Puzzle):
		parent = parent.get_parent()

	return parent if parent != null else null
	
	
func check_puzzle_completed() -> void:
	
	var ok = move_remaining >= 0
	for pos in tiles:
		ok = ok and (not tiles[pos].has_collectible or tiles[pos].collected)
		
	if ok:
		print("Level completed!!")


func on_player_move_completed() -> void:
	move_remaining -= 1
	update_ui()
	check_puzzle_completed()

func on_player_used_powerup() -> void:
	move_remaining -= 1
	update_ui()
	check_puzzle_completed()

func update_ui() -> void:
	for it in ui.items:
		it.set_use_count(player.power_ups[it.type])
		
	ui.update_label_ui(move_remaining)
		
