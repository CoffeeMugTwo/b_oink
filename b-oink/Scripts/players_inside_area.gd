extends Area3D

signal all_players_inside
signal player_entered_box
# Called when the node enters the scene tree for the first time.
var players_in_zone: Array = []

func _ready() -> void:
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	emit_signal("player_entered_box")
	if body.is_in_group("players") and body not in players_in_zone:
		players_in_zone.append(body)
		_check_all_players_inside()

func _on_body_exited(body):
	if body.is_in_group("players") and body in players_in_zone:
		players_in_zone.erase(body)

func _check_all_players_inside():
	var total_players = get_tree().get_nodes_in_group("players").size()
	if players_in_zone.size() == total_players:
		emit_signal("all_players_inside")
