extends Resource
class_name TileTheme

@export var bg_color: Color

@export var tileset: TileSet
@export var tiles_full: Array[Vector2i]
@export var tiles_bl: Array[Vector2i]
@export var tiles_br: Array[Vector2i]
@export var tiles_tl: Array[Vector2i]
@export var tiles_tr: Array[Vector2i]
@export var tiles_b: Array[Vector2i]
@export var tiles_t: Array[Vector2i]
@export var tiles_l: Array[Vector2i]
@export var tiles_r: Array[Vector2i]

func get_tile_position(top: bool, right: bool, bottom: bool, left: bool) -> Vector2i:
	if top and not right and not left and not bottom:
		return get_random_from_arr(tiles_t)
	elif bottom and not right and not left and not top:
		return get_random_from_arr(tiles_b)
	elif right and not top and not left and not bottom:
		return get_random_from_arr(tiles_r)
	elif left and not right and not top and not top:
		return get_random_from_arr(tiles_l)
	elif top and left and not right and not bottom:
		return get_random_from_arr(tiles_tl)
	elif top and right and not left and not bottom:
		return get_random_from_arr(tiles_r)
	elif bottom and left and not right and not top:
		return get_random_from_arr(tiles_bl)
	elif bottom and right and not left and not top:
		return get_random_from_arr(tiles_br)
	else:
		return get_random_from_arr(tiles_full)


func get_random_from_arr(arr: Array[Vector2i]) -> Vector2:
	return arr[randi() % len(arr)]
