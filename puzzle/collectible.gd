extends Node2D

var initial_position: Vector2

@export var float_amplitude := 20.0
@export var float_frequency := 1.0 / 5.0
@export var float_spacial_frequency := 1.0 / 200.0

func _ready() -> void:
	rotation_degrees = randf() * 360.0
	initial_position = position
	
	
func _process(delta: float) -> void:
	var time := float(Time.get_ticks_msec()) / 1000.0
	var phi := time * float_frequency + (initial_position.x + initial_position.y) * float_spacial_frequency
	position = initial_position + Vector2.UP * float_amplitude * sin(2 * PI * phi)
