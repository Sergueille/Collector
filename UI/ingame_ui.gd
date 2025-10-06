extends Control

signal back_to_menu
signal restart

@export var items: Array[InventoryItem]
@export var move_count_label: Label

@export var tuto_images: Dictionary[int, Texture2D]

func update_label_ui(remaining_moves: int) -> void:
	move_count_label.text = str(remaining_moves)
	
func bubble_back_to_menu() -> void:
	back_to_menu.emit()

func bubble_restart() -> void:
	restart.emit()

func set_tuto_image(level_id: int) -> void:
	if level_id in tuto_images:
		$Tuto.texture = tuto_images[level_id]
		$Tuto.visible = truex
	else:
		$Tuto.visible = false
