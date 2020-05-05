extends TileMap

const N = 1
const E = 2
const S = 4
const W = 8

var directions = {
	"up": N,
	"right": E,
	"down": S,
	"left": W,
}

var grid_size : Vector2

func _ready():
	var width = ProjectSettings.get_setting("display/window/size/width")
	var height = ProjectSettings.get_setting("display/window/size/height")
	grid_size = Vector2(width / cell_size.x, height / cell_size.y)
	
func clear_plane(plane):
	var width = grid_size.x * plane.x
	var height = grid_size.y * plane.y
	
	for x in range(width):
		for y in range(height):
			var pos = Vector2(x, y)
			var tile = randi() % 4
			set_cellv(pos, tile)

func place_room(location, room):
	# North wall
	
	var pos = grid_size * location
	
	fill(pos + Vector2(0,0), pos + Vector2(19,2), true)
	if (direction(room, "up")):
		fill(pos + Vector2(8,0), pos + Vector2(11,2), false)
	
	# South wall
	fill(pos + Vector2(0,15), pos + Vector2(19,17), true)
	if (direction(room, "down")):
		fill(pos + Vector2(8,15), pos + Vector2(11,17), false)
	
	# West wall
	fill(pos + Vector2(0,0), pos + Vector2(2,17), true)
	if (direction(room, "left")):
		fill(pos + Vector2(0,7), pos + Vector2(2,10), false)
	
	# East wall
	fill(pos + Vector2(17,0), pos + Vector2(19,17), true)
	if (direction(room, "right")):
		fill(pos + Vector2(17,7), pos + Vector2(19,10), false)
	
	pass
	
func fill(a, b, solid):
	var pos = Vector2(min(a.x, b.x), min(a.y, b.y))
	var size = Vector2(abs(b.x - a.x) + 1, abs(b.y - a.y) + 1)
	
	for x in range(size.x):
		for y in range(size.y):
			var tile = Vector2(pos.x + x, pos.y + y)
			if (solid):
				set_cellv(tile, (randi() % 3) + 8)
			else:
				set_cellv(tile, randi() % 4)
	pass

func direction(val, dir):
	var check = directions[dir.to_lower()]
	return (val & check) != check
