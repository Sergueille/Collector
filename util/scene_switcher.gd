extends Node

var current_scene_root: Node


func go_to_level(level_node: Node):
	_change_to_scene(level_node)

func load_scene(filename: String):
	_change_to_scene(ResourceLoader.load(filename).instantiate())

func _change_to_scene(node: Node):
	current_scene_root.queue_free()
	await current_scene_root.tree_exited
	current_scene_root = node
	get_tree().root.add_child(node)
