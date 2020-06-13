extends Actor

func _ready():
	set_physics_process(false)
	_velocity.x = -speed.x
	
func _on_StompDetector_body_entered(body: PhysicsBody2D):
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	queue_free()
	get_node("CollisionShape2D").disabled = true

func _physics_process(delta):
	_velocity.y += gravity
	if is_on_wall():
		_velocity.x *= -1
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
