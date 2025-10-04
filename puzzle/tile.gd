class_name Tile
extends Node

@export var data: TileResource

var tile_position: Vector2i
var activated: bool = false


func _ready() -> void:
	# add sprites (both for tile and for power-ups) and idk
	return


func set_activated(activated: bool):
	self.activated = activated


func apply_properties() -> void:
	for property in data.properties:
		property.apply()


static func get_tile(property: Node) -> Tile:
	var parent := property.get_parent()
	while parent != null and not (parent is Tile):
		parent = parent.get_parent()
	return parent if parent != null else null
