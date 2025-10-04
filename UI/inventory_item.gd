extends Control

@export var texture: Texture
@export var key: String

var count := 0

func _ready() -> void:
	$TextureRect.texture = texture
	$Panel/Label.text = key

func set_use_count(new_count: int) -> void:
	$Label.text = "X " + str(new_count)
	
	if new_count == 0:
		visible = false
	else:
		visible = true
		
	count = new_count
