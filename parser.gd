class_name Parser
extends Node

@export var puzzle_scene: PackedScene
@export var tile_scene: PackedScene
@export var block_property_scene: PackedScene
@export var power_up_property_scene: PackedScene

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
	var level = puzzle_scene.instantiate()

	# Variables temporaires pour stocker la propriété de chaque case
	var property
	var start_position  # Servira à mémoriser la position de départ du joueur
	
	# Parcourt la carte ligne par ligne et colonne par colonne
	for j in range(length):
		line = file.get_line()
		for i in range(width):
			# Création d’une ressource de tuile
			var tile_resource = TileResource.new()
			
			# Récupère le caractère représentant la tuile courante
			property = line[i]

			# Initialise une nouvelle tuile dans la grille du niveau
			level.tiles[Vector2i(i, j)] = tile_scene.instantiate()
			level.add_child(level.tiles[Vector2i(i,j)])

			var prop  # Stocke le type de propriété associé à la tuile

			# Associe un type de propriété selon le caractère lu
			if property == "m":
				tile_resource.properties.push_back(block_property_scene)       # "m" → mur ou bloc infranchissable
				tile_resource.atlas_coordinates = Vector2i(0,0) # TEST
			elif property == "v":
				tile_resource.atlas_coordinates = Vector2i(1,0) # TEST
			elif property == "p":
				start_position = Vector2i(i, j)  # on enregistre la position de départ
				tile_resource.atlas_coordinates = Vector2i(2,0) # TEST
				level.player.current_position = Vector2i(i, j) 
			elif property == "d":
				tile_resource.atlas_coordinates = Vector2i(3,0) # TEST
				tile_resource.properties.push_back(power_up_property_scene)
			elif property == "a":
				tile_resource.atlas_coordinates = Vector2i(4,0) # TEST
				tile_resource.properties.push_back(power_up_property_scene)     # "a" → autre type de bonus (à clarifier)
			# Ajoute la propriété à la ressource et l’associe à la tuile
			level.tiles[Vector2i(i, j)].data = tile_resource
	level.set_level()
	return level
	
	# Retourne un dictionnaire contenant toutes les informations utiles du niveau
	return {
		"name": name,
		"length": length,
		"width": width,
		"min_cost": min_cost,
		"start_position": start_position,
		"level": level
	}
