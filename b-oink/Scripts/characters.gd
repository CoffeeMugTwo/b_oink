extends Node3D

@onready var player_back: Node3D = $PlayerBack
@onready var player_head: Node3D = $PlayerHead
@onready var spring: Node3D = $Spring

func _process(_delta):
	var pos_a: Vector3 = player_back.global_position
	var pos_b: Vector3 = player_head.global_position
	print("characters script: ", pos_a)
	# Midpoint between the two players
	spring.global_position = (pos_a + pos_b) * 0.5

	# Direction vector A → B
	var dir: Vector3 = pos_b - pos_a
	dir.z = 0  # lock to 2.5D plane (XY)

	# Compute rotation angle in radians
	var angle = atan2(dir.y, dir.x)

	# Apply rotation (make sure your spring’s forward axis is +X)
	spring.rotation = Vector3(0, 0, angle)

	# Stretch spring along X axis based on distance
	var distance = dir.length()

	# Store original scale (so it doesn't distort over time)
	var base_scale = Vector3(1, 1, 1)

	# Apply stretch only on X axis
	spring.scale = Vector3(distance, base_scale.y, base_scale.z)
