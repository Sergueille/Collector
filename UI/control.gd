extends Control

# Charger le script parser
# const Parser = preload("res://parser.gd")


func _on_play_button_1_pressed() -> void:
	var level = LevelParser.createMapFromFile("levels/niveau1.txt")
	SceneSwitcher.go_to_level(level)

func _go_to_levels_screen() -> void:
	get_tree().change_scene_to_file("res://UI/level_selection.tscn")


func _on_play_button_2_pressed() -> void:
	var level = LevelParser.createMapFromFile("levels/niveau2.txt")
	SceneSwitcher.go_to_level(level)

func _on_credit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/credit/credit_ui.tscn")

func _go_to_main_menu() -> void:
	get_tree().change_scene_to_file("res://UI/menu_ui.tscn")


