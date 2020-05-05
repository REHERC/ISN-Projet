extends Node2D

onready var Layout = get_node("Layout")
onready var Level = get_node("Level")

var size : Vector2 = Vector2(6, 6)

func _ready():
	Layout.generate(size)
	Level.clear_plane(size)
	for x in range(size.x):
		for y in range(size.y):
			var pos = Vector2(x, y)
			var room = Layout.get_tile(pos)
			Level.place_room(pos, room)
