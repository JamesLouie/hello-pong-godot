extends CharacterBody2D

var speed = 400
var initial_direction = Vector2(1, 0.5).normalized()
var paddle_height = 100.0  # Adjust this to match your actual paddle height

func _ready():
	# Set collision layers and masks for proper physics
	collision_layer = 1
	collision_mask = 1
	print("Ball initialized: collision_layer: ", collision_layer, " collision_mask: ", collision_mask)
	
	# Start ball movement after a short delay
	await get_tree().create_timer(1.0).timeout
	start_movement()

func start_movement():
	# Randomize initial direction slightly
	var random_angle = randf_range(-PI/4, PI/4)
	velocity = initial_direction.rotated(random_angle) * speed

func _physics_process(delta):
	# Store previous velocity for collision calculations
	var previous_velocity = velocity
	
	# Move the ball
	var collision = move_and_slide()
	
	# Handle collisions - process only the first collision to avoid multiple bounces per frame
	if get_slide_collision_count() > 0:
		var collision_info = get_slide_collision(0)
		var collider = collision_info.get_collider()
		var collision_normal = collision_info.get_normal()
		var collision_point = collision_info.get_position()
		
		print("Ball collided with: ", collider.name, " Normal: ", collision_normal)
		
		# Check if this is a paddle collision
		if collider is CharacterBody2D and collider != self:
			handle_paddle_collision(collider, collision_point, collision_normal, previous_velocity)
		else:
			# Wall collision - simple reflection
			handle_wall_collision(collision_normal, previous_velocity)

func handle_paddle_collision(paddle: CharacterBody2D, collision_point: Vector2, normal: Vector2, prev_velocity: Vector2):
	print("Paddle collision detected!")
	
	# Calculate hit factor based on actual collision point relative to paddle center
	var paddle_center = paddle.global_position
	var hit_offset = collision_point.y - paddle_center.y
	var hit_factor = clamp(hit_offset / (paddle_height * 0.5), -1.0, 1.0)
	
	# Base reflection using the collision normal
	var reflected_velocity = prev_velocity.bounce(normal)
	
	# Apply angle variation based on hit position
	# Hit factor of -1 (top) = deflect upward, +1 (bottom) = deflect downward
	var angle_variation = hit_factor * PI / 6  # Max 30 degree variation
	var final_velocity = reflected_velocity.rotated(angle_variation)
	
	# Add paddle movement influence
	var paddle_velocity_influence = paddle.velocity.y * 0.3  # 30% of paddle velocity
	final_velocity.y += paddle_velocity_influence
	
	# Ensure minimum horizontal speed to prevent nearly vertical trajectories
	var min_horizontal_speed = speed * 0.3
	if abs(final_velocity.x) < min_horizontal_speed:
		final_velocity.x = min_horizontal_speed * sign(final_velocity.x)
	
	# Normalize to maintain consistent speed
	velocity = final_velocity.normalized() * speed
	
	print("Hit factor: ", hit_factor, " Angle variation: ", angle_variation)
	print("Paddle velocity influence: ", paddle_velocity_influence)
	print("Final velocity: ", velocity)

func handle_wall_collision(normal: Vector2, prev_velocity: Vector2):
	print("Wall collision detected!")
	
	# Simple reflection for walls
	velocity = prev_velocity.bounce(normal).normalized() * speed
	
	print("Wall bounce velocity: ", velocity)
