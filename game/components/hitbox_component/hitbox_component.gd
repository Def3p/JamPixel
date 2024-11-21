class_name HitboxComponent

extends Area3D

@export var type : String
@export var object : Node3D

func activation():
	object.activation()
