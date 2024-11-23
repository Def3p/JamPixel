extends Node3D


var load_player = preload("res://scenes/entity/player/player.tscn")
@export var spawn_pos : Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = load_player.instantiate()
	add_child(player)
	player.global_position = spawn_pos.global_position
