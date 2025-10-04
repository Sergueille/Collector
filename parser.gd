extends Object


func createMapFromFile(filename):
	if not FileAccess.file_exists(filename):
		return
	var file = FileAccess.open(filename, FileAccess.READ)
	var line = file.get_line()
	var name = line
	var len = file.get_line()
	var wid = file.get_line()
	var min_cost = file.get_line()
	
	var level = Puzzle.new()
	var property
	var start_position
	for i in range(len):
		for j in range(wid) :
			
			var ressource = TileResource.new()
			property = line[j] 
			level.tiles[Vector2i(i,j)] = Tile.new()
			var prop : TileProperty
			
			if property == "m" :
				prop = BlockProperty.new()
				
			elif property == "v" :
				prop = TileProperty.new()
				
			elif property == "p" :
				prop = TileProperty.new()
				#noter position de départ
			elif property == "d" : 
				prop = PowerUpProperty.new()
			elif property == "a" :
				prop = PowerUpProperty.new()
				
			ressource.properties.push_back(prop)
			level.tiles[Vector2i(i,j)].data = ressource
			
