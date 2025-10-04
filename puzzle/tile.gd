class_name Tile
extends Node2D

@export var properties: Array[TileProperty]

var tile_position: Vector2i
var activated: bool = false


func set_activated(activated: bool):
	self.activated = activated


func apply_properties() -> void:
	for property in properties:
		property.apply()


static func get_tile(property: Node) -> Tile:
	var parent := property.get_parent()
	while parent != null and not (parent is Tile):
		parent = parent.get_parent()
	return parent if parent != null else null
