extends Control


func _ready() -> void:
	SceneSwitcher.current_scene_root = self
	var levels_path := "res://levels"
	var dir := DirAccess.open(levels_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(".txt"):
				_create_level_button(file_name)
			file_name = dir.get_next()
		dir.list_dir_end()

func _create_level_button(file_name: String) -> void:
	var button := Button.new()
	button.text = file_name.get_basename() # ex: "niveau1"
	$GridContainer.add_child(button)

	# On capture le nom du fichier dans une lambda
	button.pressed.connect(func():
		_on_level_button_pressed(file_name))

func _on_level_button_pressed(file_name: String) -> void:
	var level_path := "levels/%s" % file_name
	var level = LevelParser.createMapFromFile(level_path)
	SceneSwitcher.go_to_level(level)
