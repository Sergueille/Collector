extends Control


func _on_go_back_menu_button_pressed() -> void:
	SceneSwitcher.go_to_level(ResourceLoader.load("res://UI/menu_ui.tscn").instantiate())
