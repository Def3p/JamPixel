extends StaticBody3D


func _process(delta: float) -> void:
	$Coin.global_rotation.y -= 2 * delta * 5


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area is HitboxComponent:
		if area.get_parent()._Health_Component.health < 5:
			area.get_parent()._Health_Component.health += 1
