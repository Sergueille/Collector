extends Object

# TODO find a reasonable tile size
const TILE_SIZE = 438
const TILE_OFFSET = Vector2i(TILE_SIZE, TILE_SIZE) / 2

const PARTICLES_OFFSET = 2500

const COLLECTIBLES_THEMES_COUNT = 3

enum PowerUp {
	MAGNET,
	DASH,
}
