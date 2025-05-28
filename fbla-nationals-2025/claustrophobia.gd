extends Node2D

@onready var player := $Player
@onready var left_wall := $LeftWall
@onready var right_wall := $RightWall
@onready var exit_area := $Exit
@onready var camera := $Camera2D
@onready var spawner := $ObstacleSpawner
@onready var hud := $HUD

var game_won := false
var left_wall_x := 100
var right_wall_x := 1100  # example: window width - 100
var wall_shrink_speed := 100.0 / 10.0

func _process(delta):
	if game_won:
		return

	# Shrink walls
	left_wall_x += wall_shrink_speed * delta
	right_wall_x -= wall_shrink_speed * delta
	left_wall.position.x = left_wall_x
	right_wall.position.x = right_wall_x

	# Follow player
	camera.position.y = player.position.y

	# Win check
	if player.global_position.y <= exit_area.global_position.y + 80 and \
	   player.global_position.x + player.get_node("CollisionShape2D").shape.extents.x > exit_area.global_position.x and \
	   player.global_position.x < exit_area.global_position.x + 40:
		win_game()

	# Out of bounds (left/right)
	if player.global_position.x < left_wall_x or player.global_position.x > right_wall_x:
		reset_game()

func win_game():
	game_won = true
	hud.show_message("You Escaped! Press ESC to continue.")

func reset_game():
	player.position = Vector2(400, 5000)
	left_wall_x = 100
	right_wall_x = 1100
	game_won = false
