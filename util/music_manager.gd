extends Node
class_name MusicManager

@export var music_file: AudioStream

func _ready() -> void:
	music_file.play()
