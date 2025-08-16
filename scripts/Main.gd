extends Node2D

@onready var left_paddle = $LeftPaddle
@onready var right_paddle = $RightPaddle
@onready var ball = $Ball
@onready var left_goal = $LeftGoal
@onready var right_goal = $RightGoal

var initial_ball_position = Vector2(640, 360)
var initial_left_paddle_position = Vector2(50, 300)
var initial_right_paddle_position = Vector2(1230, 300)

func _ready():
	# Connect goal signals
	left_goal.body_entered.connect(_on_left_goal_entered)
	right_goal.body_entered.connect(_on_right_goal_entered)

func _on_left_goal_entered(body):
	if body == ball:
		reset_game()

func _on_right_goal_entered(body):
	if body == ball:
		reset_game()

func reset_game():
	# Reset ball position and velocity
	ball.position = initial_ball_position
	ball.velocity = Vector2.ZERO
	
	# Reset paddle positions
	left_paddle.position = initial_left_paddle_position
	right_paddle.position = initial_right_paddle_position
	
	# Start ball movement after a short delay
	await get_tree().create_timer(1.0).timeout
	ball.start_movement()
