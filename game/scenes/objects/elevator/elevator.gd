extends StaticBody3D


@export var elevator_type : String
@export var door_model : Node3D
var batteries = []
var player 

func interaction(num):
	if player:
		door_model.show()
		move()

func _on_check_player_area_entered(area: Area3D) -> void:
	if area is HitboxComponent and area.get_parent() is MoveMent:
		player = area.get_parent()


func _on_check_player_area_exited(area: Area3D) -> void:
	if area is HitboxComponent and area.get_parent() is MoveMent:
		player = null
		
func move():
	if elevator_type == "lower":
		get_tree().change_scene_to_file.bind("res://scenes/levels/zone_0/zone_0.tscn").call_deferred()
	if batteries.size() == 0 and elevator_type == "upper":
		get_tree().change_scene_to_file.bind("res://scenes/levels/floor_num2/floor_2.tscn").call_deferred()
