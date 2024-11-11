extends Node3D

func _physics_process(delta: float) -> void: 
	$MeshInstance3D.rotation += Vector3(1, 1, 1) * delta / 1.8
