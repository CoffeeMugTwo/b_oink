extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var spring_force : Vector3 = Vector3(0, 0 ,0)
@export var max_input_force_scalar : float = 10.0
@export var mass : float = 1.0

func _update_velocity(delta: float) -> void:
	# update velocity according to resulting force 
	var current_force_vector : Vector3 = spring_force 
	# apply forces according to input
	if Input.is_action_pressed("ui_right"):
		current_force_vector += Vector3(1, 0 ,0 ) * max_input_force_scalar
		
	if Input.is_action_pressed("ui_left"):
		current_force_vector += Vector3(-1, 0, 0) * max_input_force_scalar
		
	var current_acceleration = current_force_vector / mass
	
	velocity += current_acceleration * delta
		
	
		 

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	_update_velocity(delta)

	position.z = 0
	move_and_slide()
