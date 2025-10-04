class_name SignalBusReceiver
extends Node

signal power_up_obtained(power_up: Globals.PowerUp)
signal power_up_used(power_up: Globals.PowerUp)

const GROUP := &'RECEIVER_GROUP'

static var _s_dirty := true
static var _s_receivers: Array[SignalBusReceiver] = []


func _enter_tree():
	add_to_group(GROUP)
	_s_dirty = true


func _exit_tree():
	_s_dirty = true


static func all(tree: SceneTree) -> Array[SignalBusReceiver]:
	if _s_dirty:
		_s_receivers.clear()
		for receiver: SignalBusReceiver in tree.get_nodes_in_group(GROUP):
			if receiver:
				_s_receivers.append(receiver)
		_s_dirty = false
	return _s_receivers
