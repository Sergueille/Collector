class_name Tile
extends Node

@export var data: TileResource
@export var collectible: Node2D
@export var collectible_sprite: Sprite2D

var tile_position: Vector2i
var has_collectible: bool = false
var collected: bool = false # Only applies if there is a collectible
var properties: Array[TileProperty] = []
var collectible_theme: int
@export var textures: Array


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
		collectible_sprite.texture = textures[collectible_theme][randi() % len(textures[collectible_theme])]
		collectible.visible = true
		
		var t := create_tween()
		collectible.scale = Vector2.ZERO
		t.tween_property(collectible, "scale", Vector2.ONE, 0.6).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	else:
		collectible.visible = false


func collect_collectible(hide_sprite: bool = true):
	collected = true
	
	if hide_sprite:
		collectible.visible = false


func apply_properties() -> void:
	for property in properties:
		property.apply()


static func get_tile(property: Node) -> Tile:
	var parent := property.get_parent()
	while parent != null and not (parent is Tile):
		parent = parent.get_parent()
	return parent if parent != null else null
