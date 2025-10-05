extends Control


func _on_go_back_menu_button_pressed() -> void:
	SceneSwitcher.go_to_level(ResourceLoader.load("res://UI/menu_ui.tscn").instantiate())
	get_tree().change_scene_to_file("res://UI/level_selection.tscn")


func _on_restart_button_pressed() -> void:
	var level = LevelParser.createMapFromFile("levels/niveau1.txt")
	SceneSwitcher.go_to_level(level)
