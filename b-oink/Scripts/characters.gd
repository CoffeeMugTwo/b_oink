extends Node3D


@onready var player_back: Node3D = $PlayerBack
@onready var player_head: Node3D = $PlayerHead
@onready var spring: Node3D = $Spring

func _process(_delta):
	var pos_a = player_back.global_position
	var pos_b = player_head.global_position

	# Midpoint between the two players
	spring.global_position = (pos_a + pos_b) * 0.5

	# Vector from A → B
	var dir = pos_b - pos_a
	dir.z = 0  # ignore Z for 2.5D

	# Rotate around Z axis (so it points correctly in 2.5D)
	spring.rotation = Vector3(0, 0, atan2(dir.y, dir.x))

	# Stretch along local X axis
	var distance = dir.length()
	spring.scale = Vector3(distance, 1, 1)
