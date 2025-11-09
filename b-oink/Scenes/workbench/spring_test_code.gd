extends Node3D

@onready var player_back: Node3D = $butt/butt_anker
@onready var player_head: Node3D = $head/head_anker
@onready var spring: Node3D = $Spring

func _process(_delta):
	var pos_a = player_back.global_position
	var pos_b = player_head.global_position
	pos_a.z = 0
	pos_b.z = 0

	# Midpoint
	spring.global_position = (pos_a + pos_b) * 0.5
	# Rotate spring to face head
	spring.look_at(pos_b, Vector3.UP)

	# Distance
	var distance = (pos_b - pos_a).length()

	# Scale along local X (assuming spring is modeled along X)
	var s = spring.scale
	s.z = distance * 0.5 * 0.5/0.3   # 0.5 if pivot is centered
	spring.scale = s
