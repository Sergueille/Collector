extends Control


@export var items: Array[InventoryItem]
@export var move_count_label: Label

func update_label_ui(remaining_moves: int) -> void:
	move_count_label.text = str(remaining_moves)
