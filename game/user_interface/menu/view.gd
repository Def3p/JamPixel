extends Node3D

func _physics_process(delta: float) -> void:
	$Camera3D.rotation.y += -0.1 * delta
