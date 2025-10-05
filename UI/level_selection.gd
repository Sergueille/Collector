extends Control

@onready var buttons_container: GridContainer = $IngameUI/ButtonsContainer/GridContainer
var play_button_scene := preload("res://UI/play_button_N.tscn")

func _ready() -> void:
	var levels_path := "res://levels"
	var dir := DirAccess.open(levels_path)
	var files: Array[String] = []

	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(".txt"):
				files.append(file_name)
			file_name = dir.get_next()
		dir.list_dir_end()

	# Tri par numéro
	files.sort_custom(func(a, b):
		var num_a = int(a.get_basename())
		var num_b = int(b.get_basename())
		return num_a < num_b
	)

	# Création des boutons dans l'ordre
	for file_name in files:
		_create_level_button(file_name)
		

func _create_level_button(file_name: String) -> void:
	var play_button = play_button_scene.instantiate()
	play_button.text = (file_name.get_basename()).replace("niveau", "")
	$GridContainer.add_child(play_button)
	# On capture le nom du fichier dans une lambda
	play_button.pressed.connect(func():
		_on_level_button_pressed(file_name))

func _on_level_button_pressed(file_name: String) -> void:
	var level = LevelParser.createMapFromFile(int(file_name.get_basename()))
	SceneSwitcher.go_to_level(level)


func _go_to_main_menu() -> void:
	SceneSwitcher.go_to_level(ResourceLoader.load("res://UI/menu_ui.tscn").instantiate())
