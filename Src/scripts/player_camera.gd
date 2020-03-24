# https://www.youtube.com/watch?v=lNNO-Gh5j78&vl=en

extends Position2D

var grid_size = Vector2()
var grid_position = Vector2()

var offset = Vector2()

onready var parent = get_parent()

func _ready():
	var grid_width = ProjectSettings.get_setting("display/window/size/width")
	var grid_height = ProjectSettings.get_setting("display/window/size/height")
	offset = Vector2(round(grid_width / 2), round(grid_height / 2))
	
	grid_size = Vector2(grid_width, grid_height)
	set_as_toplevel(true)
	update_position()

func _physics_process(delta):
	update_position()

func update_position():
	var x = round((parent.position.x - offset.x) / grid_size.x)
	var y = round((parent.position.y - offset.y) / grid_size.y)
	var new_position = Vector2(x, y)
	#if (grid_position == new_position):
	#	return
		
	grid_position = new_position
	position = grid_position * grid_size + offset
