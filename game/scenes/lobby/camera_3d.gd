extends Node3D

var mouse_sens : float = 0.1

@onready var head: Node3D = $Head

func _ready(): Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		rotation.y = clamp(rotation.y, deg_to_rad(-40), deg_to_rad(170))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-100), deg_to_rad(100))
