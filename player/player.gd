class_name Player
extends Node2D

signal used_powerup()
signal move_completed()

const MOVEMENT_DURATION = 0.13
const JUMP_AMOUNT = 60

@export var power_ups: Dictionary[Globals.PowerUp, int] # power-up type - quantity
@export var sender: SignalBusSender

@export var up_sprite: Texture2D 
@export var down_sprite: Texture2D 
@export var left_sprite: Texture2D 
@export var right_sprite: Texture2D 

var current_position: Vector2i = Vector2i.ZERO
var movement_direction: Vector2i = Vector2i.ZERO
var target_position: Vector2i = Vector2i.ZERO

var movement_tween: Tween = null
var movement_cooldown: SceneTreeTimer = null
var moving: bool = false


func _ready() -> void:
	snap()


func _process(delta: float) -> void:
	if movement_direction != Vector2i.ZERO:
		target_position = current_position + movement_direction
		move()
	
	
func move():
	movement_direction = Vector2i.ZERO
	var puzzle = Puzzle.get_puzzle(self)
	if not puzzle.tiles.has(target_position):
		return
	puzzle.tiles[target_position].apply_properties()
	
	if target_position != current_position:
		moving = true
		if movement_tween:
			movement_tween.kill()
			movement_tween = null
		movement_tween = create_tween()
		var start_position = position
		var final_position = Vector2(target_position * Globals.TILE_SIZE + Globals.TILE_OFFSET)
		var shift = Vector2.UP * JUMP_AMOUNT
		movement_tween.tween_property(self, "position", (final_position - start_position) * 0.5 + start_position + shift, MOVEMENT_DURATION * 0.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
		movement_tween.tween_property(self, "position", final_position, MOVEMENT_DURATION * 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		await movement_tween.finished
		current_position = target_position
		puzzle.tiles[current_position].collect_collectible()
		snap()
		movement_tween = null
		moving = false
		move_completed.emit()
		
	#movement_finished.emit()


func add_power_up(type: Globals.PowerUp):
	power_ups[type] += 1


func use_power_up(type: Globals.PowerUp):
	if power_ups[type] <= 0:
		return
	for power_up in get_children().filter(func(x): return x is PowerUp):
		if power_up.type == type:
			if type == Globals.PowerUp.DASH:
				power_up.dash_direction = movement_direction
			power_up.activate()
	power_ups[type] -= 1
	used_powerup.emit()

func snap():
	position = current_position * Globals.TILE_SIZE + Globals.TILE_OFFSET

func dash_movement():
	var t = create_tween()
	t.tween_property(self, "position", Vector2(current_position) * Globals.TILE_SIZE + Vector2(Globals.TILE_OFFSET), MOVEMENT_DURATION).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)


func _input(event: InputEvent) -> void:
	if moving:
		return
	if event.is_action_pressed("up"):
		movement_direction = Vector2i(0, -1)
		$Sprite2D.texture = up_sprite
	if event.is_action_pressed("right"):
		movement_direction = Vector2i(1, 0)
		$Sprite2D.texture = right_sprite
	if event.is_action_pressed("down"):
		movement_direction = Vector2i(0, 1)
		$Sprite2D.texture = down_sprite
	if event.is_action_pressed("left"):
		movement_direction = Vector2i(-1, 0)
		$Sprite2D.texture = left_sprite
	
	# If a direction is pressed
	if movement_direction != Vector2i.ZERO:
		# We check if shift is maintained
		if Input.is_action_pressed("dash"):
			use_power_up(Globals.PowerUp.DASH)
			
	elif event.is_action_pressed("magnet"): # Activation du magnet
		use_power_up(Globals.PowerUp.MAGNET)
