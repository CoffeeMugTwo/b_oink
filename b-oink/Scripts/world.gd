extends Node3D
@onready var camera: Camera3D = $Camera3D

var spawnPoint = Vector3(4, 0, 0)
var cameraLvl1 = Vector3(9.3, 4.5, 7.7)
var cameraLvl2 = Vector3(23.2, 6.4, 7.7)
var cameraLvl3 = Vector3(39.7, 10.7, 7.7)
var cameraLvl4 = Vector3(55.8, 13.4, 7.7)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_end_zone_all_players_inside() -> void:
	get_tree().change_scene_to_file("res://Scenes/win_screen.tscn")


func _on_level_1_box_all_players_inside() -> void:
	camera.global_position = cameraLvl1
	spawnPoint = Vector3(4, 0, 0)


func _on_level_2_box_all_players_inside() -> void:
	camera.global_position = cameraLvl2
	spawnPoint = Vector3(16.7, 2.9, 0)


func _on_level_3_box_all_players_inside() -> void:
	camera.global_position = cameraLvl3
	spawnPoint = Vector3(34.2, 5.7, 0)

func _on_level_4_box_all_players_inside() -> void:
	camera.global_position = cameraLvl4
	spawnPoint = Vector3(49.2, 8.2, 0)
