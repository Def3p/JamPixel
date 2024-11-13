extends CharacterBody3D


var speed 
var damage
var delate_time

var forwared_direction

func _ready() -> void:
	await get_tree().create_timer(delate_time, false).timeout
	self.queue_free()


func _physics_process(delta: float) -> void:
	velocity = forwared_direction * 10 * delta
	
func _on_area_3d_area_entered(area: Area3D) -> void:
	if area is HitboxComponent and area.get_parent() == MoveMent:
		area.get_parent()._Health_Component.damage(damage)
		queue_free()
