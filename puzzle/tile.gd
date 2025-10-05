class_name Tile
extends Node

@export var data: TileResource
@export var collectible: Node2D

var tile_position: Vector2i # TODO is this necessary? Just check in the puzzle idk
var has_collectible: bool = false
var collected: bool = false # Only applies if there is a collectible
var properties: Array[TileProperty] = []


func _ready() -> void:
	# add sprites (for the tile), instantiate all the properties
	# and add them as children and idk
	for property in data.properties:
		var property_node = property.instantiate()
		add_child(property_node)
		properties.push_back(property_node)
		
func setup_collectible() -> void:
	if has_collectible:
		collectible.position = (Vector2(tile_position) + Vector2(0.5, 0.5)) * Globals.TILE_SIZE
		collectible.visible = true
	else:
		collectible.visible = false
		

func collect_collectible():
	collected = true
	collectible.visible = false # TODO animation


func apply_properties() -> void:
	for property in properties:
		property.apply()


static func get_tile(property: Node) -> Tile:
	var parent := property.get_parent()
	while parent != null and not (parent is Tile):
		parent = parent.get_parent()
	return parent if parent != null else null
