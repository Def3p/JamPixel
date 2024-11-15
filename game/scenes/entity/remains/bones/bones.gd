extends Node3D


@onready var bones = [$Bone, $Bone2, $Bone3, $Bone4, $Bone5, $Bone6, $Bone7, $Bone8]

func _ready() -> void:
	for i in bones:
		var a = randi_range(1, 6)
		var dir_x = i.global_transform.basis.y * a
	
		
		i.apply_central_impulse(Vector3(dir_x))

func _on_timer_timeout() -> void:
	queue_free()
