class_name Tile
extends Node

@export var data: TileResource

var tile_position: Vector2i
var activated: bool = false
var properties: Array[TileProperty] = []


func _ready() -> void:
	# add sprites (for the tile), instantiate all the properties
	# and add them as children and idk
	for property in data.properties:
		var property_node = property.instantiate()
		add_child(property_node)
		properties.push_back(property_node)
	return


func set_activated(activated: bool):
	self.activated = activated
	print("activated!! ", tile_position)
	# TODO update tile visually
	# it is possible to add an animation by instancing an animation
	# scene just on top of the tile or something


func apply_properties() -> void:
	for property in properties:
		property.apply()


static func get_tile(property: Node) -> Tile:
	var parent := property.get_parent()
	while parent != null and not (parent is Tile):
		parent = parent.get_parent()
	return parent if parent != null else null
