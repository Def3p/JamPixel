extends CharacterBody3D


var speed = 10
var _damage = 1
var delate_time = 5
var stop = false

var forwared_direction

func _ready() -> void:
	await get_tree().create_timer(delate_time, false).timeout
	self.queue_free()


func _physics_process(delta: float) -> void:
	velocity = forwared_direction * 10 * delta * 300
	move_and_slide()
	
func _on_area_3d_area_entered(area: Area3D) -> void:
	if area is HitboxComponent:
		if !stop:
			stop = true
			print(_damage)
			area.get_parent()._Health_Component.damage(_damage)
			queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	print(body)
	queue_free()

func _on_area_3d_2_body_entered(body: Node3D) -> void:
	print(body)
	queue_free()
