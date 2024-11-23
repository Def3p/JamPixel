class_name Mob_Spawn_Manager

extends Node

var mobs = [
preload("res://scenes/entity/mobs/enemys/knight_mob/knight_mob.tscn"), 
preload("res://scenes/entity/mobs/enemys/mid_mob/mid_mob.tscn"),
preload("res://scenes/entity/mobs/enemys/sniper_mob/sniper_mob.tscn")
]

@export var spawn_points : Array[Node3D]

func _ready() -> void:
	spawn_mob()

func spawn_mob():
	var scene = get_tree().root
	for i in spawn_points:
		var a = randi_range(0, 2)
		var mob = mobs[a].instantiate()
		add_child(mob)
		mob.reparent(scene)
		mob.global_position = i.global_position
		mob.global_position = i.global_position
		mob.global_position = i.global_position
		
