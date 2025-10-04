class_name Player
extends Node2D

# TODO we may have to add something like a tween for the player's movement, 
# and instead of defining the direction to which the player will move, maybe we can
# define the list of deplacements and create only one tween to make all of them at once

const TILE_SIZE = 16 # TODO make it global
const OFFSET = Vector2i(TILE_SIZE, TILE_SIZE) / 2
const MOVEMENT_DURATION = 0.2

@export var power_ups: Dictionary[int, PowerUp] # quantity - power-up

var current_position: Vector2i = Vector2i.ZERO
var movement_direction: Vector2i = Vector2i.ZERO

var movement_tween: Tween = null
var movement_cooldown: SceneTreeTimer = null


func _ready() -> void:
	snap()


func _process(delta: float) -> void:
	if movement_direction != Vector2i.ZERO:
		move(current_position + movement_direction)
		movement_direction = Vector2i.ZERO
	

# this will be awkward but we may have to verify if the player moved
# and it stayed in the same place because of the "block movement" effect
func move(target_position: Vector2i):
	movement_direction = Vector2i.ZERO
	var puzzle = Puzzle.get_puzzle(self)
	if not puzzle.tiles.has(target_position):
		print("buwop")
		print("quis ir pra ", current_position + movement_direction, " mas não tem nada lá")
		return
	puzzle.tiles[target_position].apply_properties()
	
	if target_position != current_position:
		print("deslocamento na direção ", target_position-current_position)
		# move was not blocked
		# run animation of player moving between tiles and block movement
		# while that happens
		if movement_tween:
			movement_tween.kill()
			movement_tween = null
		movement_tween = create_tween()
		var final_position = Vector2(target_position * TILE_SIZE + OFFSET)
		movement_tween.tween_property(self, "position", final_position, MOVEMENT_DURATION)
		await movement_tween.finished
		current_position = target_position
		snap()
		movement_tween = null
	#movement_finished.emit()


func add_power_up():
	return


func snap():
	position = current_position * TILE_SIZE + OFFSET


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		movement_direction = Vector2i(0, -1)
	if event.is_action_pressed("right"):
		movement_direction = Vector2i(1, 0)
	if event.is_action_pressed("down"):
		movement_direction = Vector2i(0, 1)
	if event.is_action_pressed("left"):
		movement_direction = Vector2i(-1, 0)
