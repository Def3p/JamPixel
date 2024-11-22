class_name Mob_Spawn_Manager

extends Node

var mobs = [
"res://scenes/entity/mobs/enemys/knight_mob/knight_mob.tscn", 
"res://scenes/entity/mobs/enemys/mid_mob/mid_mob.tscn",
"res://scenes/entity/mobs/enemys/sniper_mob/sniper_mob.tscn"
]

@export var spawn_points : Array[Node3D]

func spawn_mob():
	pass
