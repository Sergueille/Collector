extends Control


func _on_restart_button_pressed() -> void:
	var level = LevelParser.createMapFromFile("levels/niveau1.txt")
	SceneSwitcher.go_to_level(level)
