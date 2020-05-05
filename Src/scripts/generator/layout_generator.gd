extends TileMap

const N = 1
const E = 2
const S = 4
const W = 8

var cell_walls = {
	Vector2(+0, -1): N,
	Vector2(+1, +0): E,
	Vector2(+0, +1): S,
	Vector2(-1, +0): W,
}

#var size : Vector2 = Vector2(20, 18)
var size : Vector2 = Vector2(10, 9)
var passthrough_fraction : float = 0.45

func generate(dungeon_size):
	size = dungeon_size
	randomize()
	make_maze()

func check_neighbors(cell, unvisited):
	var list = []
	for n in cell_walls.keys():
		if cell + n in unvisited:
			list.append(cell + n)
	return list

func make_maze():
	passthrough_fraction = (randf() * 0.45) + 0.045
	clear()
	var unvisited = []
	var map = []
	var stack = []
	
	for x in range(size.x):
		for y in range(size.y):
			unvisited.append(Vector2(x, y))
			map.append(Vector2(x, y))
			set_cellv(Vector2(x, y), N|E|S|W)
			
	var current : Vector2 = unvisited[randi() % unvisited.size()]
	unvisited.erase(current)
	
	while unvisited:
		var neighbors = check_neighbors(current, unvisited)
		if neighbors.size() > 0:
			var next = neighbors[randi() % neighbors.size()]
			stack.append(current)
			var direction : Vector2 = next - current
			var new_current_walls_mask = get_cellv(current) - cell_walls[direction]
			var new_next_walls_mask = get_cellv(next) - cell_walls[-direction]
			set_cellv(current, new_current_walls_mask)
			set_cellv(next, new_next_walls_mask)
			
			current = next
			unvisited.erase(current)
		elif stack:
			current = stack.pop_back()
	
	for i in range(int(size.x * size.y * passthrough_fraction)):
		var cell : Vector2 = map[randi() % map.size()]
		var next = Vector2(0, 0)
		
		while next.length() == 0 || not (cell + next in map):
			next = cell_walls.keys()[randi() % cell_walls.size()]
		
		if get_cellv(cell) & cell_walls[next]:
			var cell_wall_mask = get_cellv(cell) - cell_walls[next]
			var next_cell_wall_mask = get_cellv(cell + next) - cell_walls[-next]
			set_cellv(cell, cell_wall_mask)
			set_cellv(cell + next, next_cell_wall_mask)

func get_tile(location):
	return get_cellv(location)
				
func _physics_process(delta):
	pass
