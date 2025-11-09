extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var spring_force : Vector3 = Vector3(0, 0 ,0)
@export var max_input_force_scalar : float = 50.0
@export var mass : float = 1.3
@export var jump_force_scalar : float = 1000 #370
@export var max_grab_distance : float = 0.7

func _can_grab() -> bool:
	var space_state = get_world_3d().direct_space_state
	var sphere = SphereShape3D.new()
	sphere.radius = max_grab_distance
	var query = PhysicsShapeQueryParameters3D.new()
	query.shape = sphere
	query.transform.origin = global_position
	query.collide_with_areas = false
	query.collide_with_bodies = true
	
	var results = space_state.intersect_shape(query, 1)
	for r in results:
		var collider = r["collider"]
		if collider is StaticBody3D:
			return true
			
	return false

func _update_velocity(delta: float) -> void:
	# update velocity according to resulting force 
	var current_force_vector : Vector3 = spring_force 
	# apply forces according to input
	if Input.is_action_pressed("p2_right"):
		current_force_vector += Vector3(1 ,0 ,0 ) * max_input_force_scalar
		
	if Input.is_action_pressed("p2_left"):
		current_force_vector += Vector3(-1, 0, 0) * max_input_force_scalar
		
	if Input.is_action_pressed("p2_jump") and is_on_floor():
		current_force_vector += Vector3(0, 1, 0) * jump_force_scalar
		
	var current_acceleration = current_force_vector / mass
	
	##print("Butt")
	##print("current acceleration")
	##print(current_acceleration)
	
	velocity += current_acceleration * delta
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if not is_on_floor():
		velocity +=  get_gravity() * delta

	_update_velocity(delta)
	
		# handle grap
	if Input.is_action_pressed("p2_hold") and _can_grab():
		velocity = Vector3(0, 0, 0)

	position.z = 0
	move_and_slide()
