extends Object

func createMapFromFile(filename):
	if not FileAccess.file_exists(filename):
		return
	var file = FileAccess.open(filename, FileAccess.READ)
	var line
	while(line = file.get_line() != EOF):
		if line != "":
			var name = line
			var len = file.get_line()
			var wid = file.get_line()
			// Convertir dim en intj = file.get_8()
			
			//var level = Level...
			
			for i in range(len):
				var j = file.get_8()
				var k = 0
				while j != '\n':
					var property = j... //Utilisation enum
					level.tiles[i][k] = Tile(i, k, property)
					k++
					j = file.get_8()
