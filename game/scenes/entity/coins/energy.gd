extends StaticBody3D


func _process(delta: float) -> void:
	$Cylinder_024.global_rotation.y -= 2 * delta * 2


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area is HitboxComponent:
		global_var.energy += 1
		queue_free()
