# https://www.youtube.com/watch?v=4CLvL05Av6g

extends KinematicBody2D

var speed = 0
const walk_speed = 3500
const run_speed = 9300

var velocity = Vector2(0, 0)

func update_controls():
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	
	var running = Input.is_action_pressed("ui_shift")
	
	if (running):
		speed = run_speed
	else:
		speed = walk_speed
	
	var normalized_velocity = Vector2(0, 0)
	normalized_velocity.x = -int(left) + int(right)
	normalized_velocity.y = -int(up) + int(down)
	
	velocity = normalized_velocity.normalized()

func update_velocity(delta):
	var motion = velocity * speed * delta
	move_and_slide(motion, Vector2(0, 0))

func _physics_process(delta):
	update_controls()
	update_velocity(delta)
