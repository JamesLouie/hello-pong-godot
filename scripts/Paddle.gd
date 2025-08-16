extends CharacterBody2D

@export var is_left: bool = true
var speed = 400

func _ready():
	# Set collision layers and masks for proper physics
	collision_layer = 1
	collision_mask = 1
	print("Paddle initialized: ", name, " is_left: ", is_left, " collision_layer: ", collision_layer)

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	if is_left:
		# Left paddle controls (W/S keys)
		if Input.is_key_pressed(KEY_W):
			direction.y = -1
		if Input.is_key_pressed(KEY_S):
			direction.y = 1
	else:
		# Right paddle controls (Up/Down arrow keys)
		if Input.is_key_pressed(KEY_UP):
			direction.y = -1
		if Input.is_key_pressed(KEY_DOWN):
			direction.y = 1
	
	velocity = direction * speed
	move_and_slide()
	
	# Keep paddle within screen bounds
	position.y = clamp(position.y, 50, 670)
