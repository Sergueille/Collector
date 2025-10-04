extends Control

# Charger le script parser
# const Parser = preload("res://parser.gd")


func _on_play_button_1_pressed() -> void:
	var level = LevelParser.createMapFromFile("levels/niveau1.txt")
	SceneSwitcher.go_to_level(level)


func _on_play_button_2_pressed() -> void:
	var level = LevelParser.createMapFromFile("levels/niveau2.txt")
	SceneSwitcher.go_to_level(level)

func _on_credit_button_pressed() -> void:
	var level = LevelParser.createMapFromFile("levels/niveau3.txt")
	SceneSwitcher.go_to_level(level)
