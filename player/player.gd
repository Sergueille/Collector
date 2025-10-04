class_name Player
extends Node2D


var current_position: Vector2i
var movement_direction: Vector2i
var power_ups: Dictionary[int, PowerUp] # quantity - power-up


# this will be awkward but we may have to verify if the player moved
# and it stayed in the same place because of the "block movement" effect
func move():
	var puzzle = Puzzle.get_puzzle(self)
	if puzzle.tiles.has(current_position + movement_direction):
		puzzle.tiles[current_position + movement_direction].apply()
	
	if movement_direction != Vector2i.ZERO:
		# move was not blocked
		pass


func add_power_up():
	return
