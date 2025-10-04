extends Object

func createMapFromFile(filename):
	if not FileAccess.file_exists(filename):
		return
	var file = FileAccess.open(filename, FileAccess.READ)
	var line = file.get_line()
	var name = line
	var len = file.get_line()
	var wid = file.get_line()
	var coup_min = file.get_line()
	#Convertir dim en intj = file.get_8()
	
	#var level = Level...
	var property
	for i in range(len):
		for j in range(wid) : 
			property = line[j] 
			if porperty = "m" :
				level.tiles[i][j] = Tile(i, j, property)
			elif porperty = "v" :
				level.tiles[i][j] = Tile(i, j, property)
			elif porperty = "p" :
				level.tiles[i][j] = Tile(i, j, property)
			elif porperty = "d" : 
				level.tiles[i][j] = Tile(i, j, property)
			elif porperty = "a" :
				level.tiles[i][j] = Tile(i, j, property)
			
