extends Control


func _on_credit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/menu_ui.tscn")
