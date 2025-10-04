extends Control

# Charger le script parser
# const Parser = preload("res://parser.gd")


func _on_play_button_1_pressed() -> void:
#	var parser = Parser.new()
#	parser.createMapFromFile("niveau1.txt")
	get_tree().change_scene_to_file("res://UI/ingame_ui.tscn")


func _on_play_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/ingame_ui.tscn")


func _on_credit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/credit/credit_ui.tscn")
