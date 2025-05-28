extends Area2D

@export var speed = 300  # You can adjust this in the Inspector
var velocity = Vector2.ZERO

func _process(delta):
	# Get input direction
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	# Normalize and apply speed
	if input_vector.length() > 0:
		velocity = input_vector.normalized() * speed
	else:
		velocity = Vector2.ZERO
	
	# Move the player
	position += velocity * delta
