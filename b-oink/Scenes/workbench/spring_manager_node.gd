extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
@export var a: CharacterBody3D
@export var b: CharacterBody3D

@export var anchor_a: Marker3D
@export var anchor_b: Marker3D

@export var rest_length: float = 3   # meters
@export var stiffness_k: float = 5.0  # spring strength
@export var damping_c: float = 3.0     # damping
@export var max_force: float = 200.0   # safety clamp
@export var mass_a: float = 1.0
@export var mass_b: float = 1.0
@export var hard_max_length: float = 0  # 0 = off; >0 acts like a rope cap

func _physics_process(delta: float) -> void:
	var pa: Vector3 = anchor_a.global_transform.origin
	var pb: Vector3 = anchor_b.global_transform.origin
	var d: Vector3 = pb - pa
	var dist := d.length()
	if dist <= 0.0001:
		return
	var n := d / dist

	# Hooke’s law with damping on the line of action:
	var x := dist - rest_length
	var rel_speed := (b.velocity - a.velocity).dot(n)
	var f_scalar := -stiffness_k * x - damping_c * rel_speed 
	f_scalar = clamp(f_scalar, -max_force, max_force)
	var F := n * f_scalar

	# Apply "forces" as velocity changes before move_and_slide():
	a.spring_force = -F
	b.spring_force = F
	# a.velocity += (-F / mass_a) * delta
	# b.velocity -= (+F / mass_b) * delta

	# Optional: hard rope cap (prevents stretching beyond a length)
	if hard_max_length > 0.0 and dist > hard_max_length:
		pass
		var excess := dist - hard_max_length
		# Pull them together proportionally; treat as strong impulse:
		var pull: Vector3 = n * min(excess / max(delta, 0.001), 50.0)  # simple corrective
		a.velocity +=  pull * delta
		b.velocity += -pull * delta
