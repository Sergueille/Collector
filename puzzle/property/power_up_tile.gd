class_name PowerUpProperty
extends TileProperty

# this tile gives the player a power-up

@export var power_up: Globals.PowerUp

var already_picked_up := false

func _ready() -> void:
	$Sprite2D.initial_position = (Vector2(get_tile(self).tile_position) + Vector2(0.5, 0.5)) * Globals.TILE_SIZE

func _apply():
	if already_picked_up:
		return
	
	var player = Puzzle.get_puzzle(self).player
	player.add_power_up(power_up)
	already_picked_up = true
	
	var pos: Vector2 = $Sprite2D.position
	
	var t := create_tween()
	t.tween_property($Sprite2D, "position", Vector2(pos.x, 3000), 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	t = create_tween()
	t.tween_property($Sprite2D, "modulate", Color(1, 1, 1, 0), 0.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	
	t.finished.connect(func(): $Sprite2D.visible = false)
	
	# queue_free()
