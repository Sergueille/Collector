class_name Parser
extends Node

@export var puzzle_scene: PackedScene
@export var theme: TileTheme
@export var tile_scene: PackedScene
@export var block_property_scene: PackedScene
@export var dash_property_scene: PackedScene
@export var magnet_property_scene: PackedScene

# Fonction qui lit un fichier texte et génère une carte (Puzzle) à partir de son contenu.
# Le fichier doit contenir :
#   - une ligne avec le nom du niveau
#   - une ligne avec la longueur
#   - une ligne avec la largeur
#   - une ligne avec le coût minimal
#   - puis la grille représentant les tuiles du niveau
func createMapFromFile(level_id):
	var filename := "res://levels/" + str(level_id) + ".txt"
	
	# Vérifie que le fichier existe avant de tenter de l'ouvrir
	if not FileAccess.file_exists(filename):
		return 0

	# Ouvre le fichier en lecture
	var file = FileAccess.open(filename, FileAccess.READ)
	
	# Lecture des métadonnées du niveau (nom, dimensions, coût minimal)
	var line = file.get_line()

	var str_len = file.get_line()
	var length = str_len.to_int()

	var str_wid = file.get_line()
	var width = str_wid.to_int()

	var str_min_cost = file.get_line()
	var min_cost = str_min_cost.to_int()

	# Création d’un nouvel objet Puzzle (niveau)
	var level = puzzle_scene.instantiate()
	level.move_remaining = min_cost
	level.level_size = Vector2i(width, length)
	level.level_id = level_id

	# Variables temporaires pour stocker la propriété de chaque case
	var property
	
	# contient les string des tuiles de la map, exemple : [[p,v,m,v], [m,v,v,v]]
	var tab_map = []

	# Parcourt la carte ligne par ligne et colonne par colonne
	for i in range(length):
		tab_map.append([])
		line = file.get_line()
		for j in range(width):
			tab_map[i].append(line[j])


	# Parcourt la carte de tab_map ligne par ligne et colonne par colonne
	for j in range(length):
		for i in range(width):
			# Création d’une ressource de tuile
			var tile_resource = TileResource.new()
			
			# Récupère le caractère représentant la tuile courante
			property = tab_map[j][i]
			
			# top right down left
			var is_tile_vide = [true, true, true, true]
			
			# top
			if j - 1 < 0:
				is_tile_vide[0] = false
			elif tab_map[j-1][i] == "m":
				is_tile_vide[0] = false
			
			# right
			if i + 1 > width -1:
				is_tile_vide[1] = false
			elif tab_map[j][i+1] == "m":
				is_tile_vide[1] = false
			
			# down
			if j + 1 > length -1:
				is_tile_vide[2] = false
			elif tab_map[j+1][i] == "m":
				is_tile_vide[2] = false
			
			# left
			if i - 1 < 0:
				is_tile_vide[3] = false
			elif tab_map[j][i-1] == "m":
				is_tile_vide[3] = false

			# Initialise une nouvelle tuile dans la grille du niveau
			level.tiles[Vector2i(i, j)] = tile_scene.instantiate()
			level.tiles[Vector2i(i, j)].tile_position = Vector2i(i, j)
			level.add_child(level.tiles[Vector2i(i,j)])

			# Associe un type de propriété selon le caractère lu
			if property == "m":
				tile_resource.properties.push_back(block_property_scene)       # "m" → mur ou bloc infranchissable
				tile_resource.atlas_coordinates = theme.get_tile_position(is_tile_vide[0], is_tile_vide[1], is_tile_vide[2], is_tile_vide[3])
				tile_resource.has_sprite = false
			elif property == "v":
				tile_resource.atlas_coordinates = theme.get_tile_position(is_tile_vide[0], is_tile_vide[1], is_tile_vide[2], is_tile_vide[3])
				level.tiles[Vector2i(i, j)].has_collectible = true # Met un collectible sur la tuile
				tile_resource.has_sprite = true
			elif property == "p":
				tile_resource.atlas_coordinates = theme.get_tile_position(is_tile_vide[0], is_tile_vide[1], is_tile_vide[2], is_tile_vide[3])
				level.player.current_position = Vector2i(i, j) 
				tile_resource.has_sprite = true
			elif property == "d":
				tile_resource.atlas_coordinates = theme.get_tile_position(is_tile_vide[0], is_tile_vide[1], is_tile_vide[2], is_tile_vide[3])
				tile_resource.properties.push_back(dash_property_scene)
				tile_resource.has_sprite = true
			elif property == "a":
				tile_resource.atlas_coordinates = theme.get_tile_position(is_tile_vide[0], is_tile_vide[1], is_tile_vide[2], is_tile_vide[3])
				tile_resource.properties.push_back(magnet_property_scene)
				tile_resource.has_sprite = true
			# Ajoute la propriété à la ressource et l’associe à la tuile
			level.tiles[Vector2i(i, j)].data = tile_resource
			level.tiles[Vector2i(i, j)].setup_collectible()
	level.set_level()
	return level
