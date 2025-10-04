class_name SignalBusSender
extends Node


func send_power_up_obtained(power_up: Globals.PowerUp):
	SignalBus.send(&"power_up_obtained", [power_up])

func send_power_up_used(power_up: Globals.PowerUp):
	SignalBus.send(&"power_up_used", [power_up])
