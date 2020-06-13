extends Actor

export var stomp_impulse: float = 1000

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	var direction: = get_direction()
	_velocity = calculate_move_velocity(delta, _velocity, direction, speed)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1 if Input.get_action_strength("jump") and is_on_floor() else 0
	)

func calculate_move_velocity(
		delta: float,
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2
	) -> Vector2:
	var new_velocity: = linear_velocity

	# Left - right
	new_velocity.x = speed.x * direction.x	
	
	# Jumping
	if direction.y == -1:
		new_velocity.y = speed.y * direction.y
	else:
		# Small jump
		if Input.is_action_just_released("jump") and _velocity.y < 0:
			new_velocity.y = 0
		else:
			# Falling
			new_velocity.y += gravity * delta
	
	return new_velocity

func calculate_stomp_velocity(linear_velocity: Vector2, impuls: float) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.y = -impuls
	return new_velocity
