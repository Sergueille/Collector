extends Control

# Charger le script parser
# const Parser = preload("res://parser.gd")

@onready var buttons_container: GridContainer = $GridContainer



func _ready() -> void:
	SceneSwitcher.current_scene_root = self


func _on_play_button_1_pressed() -> void:
	var level = LevelParser.createMapFromFile("levels/niveau1.txt")
	SceneSwitcher.go_to_level(level)

func _go_to_levels_screen() -> void:
	SceneSwitcher.load_scene("res://UI/level_selection.tscn")

func _on_credit_button_pressed() -> void:
	SceneSwitcher.load_scene("res://UI/credit/credit_ui.tscn")

func _go_to_main_menu() -> void:
	SceneSwitcher.load_scene("res://UI/menu_ui.tscn")
