extends Object

# Fonction qui lit un fichier texte et génère une carte (Puzzle) à partir de son contenu.
# Le fichier doit contenir :
#   - une ligne avec le nom du niveau
#   - une ligne avec la longueur
#   - une ligne avec la largeur
#   - une ligne avec le coût minimal
#   - puis la grille représentant les tuiles du niveau
func createMapFromFile(filename):
	# Vérifie que le fichier existe avant de tenter de l'ouvrir
	if not FileAccess.file_exists(filename):
		return 0

	# Ouvre le fichier en lecture
	var file = FileAccess.open(filename, FileAccess.READ)
	
	# Lecture des métadonnées du niveau (nom, dimensions, coût minimal)
	var line = file.get_line()
	var name = line

	var str_len = file.get_line()
	var length = str_len.to_int()

	var str_wid = file.get_line()
	var width = str_wid.to_int()

	var str_min_cost = file.get_line()
	var min_cost = str_min_cost.to_int()

	# Création d’un nouvel objet Puzzle (niveau)
	var level = Puzzle.new()

	# Variables temporaires pour stocker la propriété de chaque case
	var property
	var start_position  # Servira à mémoriser la position de départ du joueur
	
	# Parcourt la carte ligne par ligne et colonne par colonne
	for i in range(length):
		for j in range(width):
			# Création d’une ressource de tuile
			var ressource = TileResource.new()

			# Récupère le caractère représentant la tuile courante
			property = line[j]

			# Initialise une nouvelle tuile dans la grille du niveau
			level.tiles[Vector2i(i, j)] = Tile.new()

			var prop  # Stocke le type de propriété associé à la tuile

			# Associe un type de propriété selon le caractère lu
			if property == "m":
				prop = BlockProperty.new()       # "m" → mur ou bloc infranchissable

			elif property == "v":
				prop = TileProperty.new()        # "v" → tuile vide ou normale

			elif property == "p":
				prop = TileProperty.new()        # "p" → point de départ
				start_position = Vector2i(i, j)  # on enregistre la position de départ

			elif property == "d":
				prop = PowerUpProperty.new()     # "d" → bonus ou item

			elif property == "a":
				prop = PowerUpProperty.new()     # "a" → autre type de bonus (à clarifier)
			
			# Ajoute la propriété à la ressource et l’associe à la tuile
			ressource.properties.push_back(prop)
			level.tiles[Vector2i(i, j)].data = ressource

	# Retourne un dictionnaire contenant toutes les informations utiles du niveau
	return {
		"name": name,
		"length": length,
		"width": width,
		"min_cost": min_cost,
		"start_position": start_position,
		"level": level
	}
