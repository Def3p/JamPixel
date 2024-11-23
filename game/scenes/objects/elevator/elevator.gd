extends StaticBody3D


@export var elevator_type : String
@export var change_scene_timer : Timer
var batteries = []
var player
@onready var animator = $AnimationPlayer

enum States {Close, Open}

@export var state : States = States.Open

func _ready() -> void:
	%dzin.play()
	animator.play("open")
	

func interaction(num):
	if player and change_scene_timer.is_stopped():
		if state == States.Open:
			state = States.Close
			animator.play("close")
			move()
		elif state == States.Close:
			state = States.Open
			animator.play("open")
			move()

func _on_check_player_area_entered(area: Area3D) -> void:
	if area is HitboxComponent and area.get_parent() is MoveMent:
		player = area.get_parent()


func _on_check_player_area_exited(area: Area3D) -> void:
	if area is HitboxComponent and area.get_parent() is MoveMent:
		player = null
		
func move():
	change_scene_timer.start()
	%going.play()
	await change_scene_timer.timeout
	if elevator_type == "lower" and state == States.Close:
		get_tree().change_scene_to_file.bind("res://scenes/levels/zone_0/zone_0.tscn").call_deferred()
	if batteries.size() == 0 and elevator_type == "upper" and state == States.Close:
		get_tree().change_scene_to_file.bind("res://scenes/levels/floor_num2/floor_2.tscn").call_deferred()

func darkness():
	$dark_timer.start()
	await $dark_timer.timeout
	$ColorRect/AnimationPlayer.play("darknet")
	
