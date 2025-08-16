extends Node2D

@onready var left_paddle = $LeftPaddle
@onready var right_paddle = $RightPaddle
@onready var ball = $Ball
@onready var left_goal = $LeftGoal
@onready var right_goal = $RightGoal
@onready var left_score_label = $UI/LeftScore
@onready var right_score_label = $UI/RightScore

var initial_ball_position = Vector2(640, 360)
var initial_left_paddle_position = Vector2(50, 300)
var initial_right_paddle_position = Vector2(1230, 300)

# Score variables
var left_score = 0
var right_score = 0

func _ready():
	# Connect goal signals
	left_goal.body_entered.connect(_on_left_goal_entered)
	right_goal.body_entered.connect(_on_right_goal_entered)
	
	# Initialize score display
	update_score_display()

func _on_left_goal_entered(body):
	if body == ball:
		# Right player scores
		right_score += 1
		update_score_display()
		reset_game()

func _on_right_goal_entered(body):
	if body == ball:
		# Left player scores
		left_score += 1
		update_score_display()
		reset_game()

func update_score_display():
	left_score_label.text = str(left_score)
	right_score_label.text = str(right_score)

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
