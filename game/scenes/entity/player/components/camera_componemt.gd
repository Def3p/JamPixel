class_name CameraComponent

extends Node

@export var mouse_sens : float = 0.1
@export var player : CharacterBody3D
@export var camera_node : Node3D
@export var camera : Camera3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		player.rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		camera_node.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		camera_node.rotation.x = clamp(camera_node.rotation.x, deg_to_rad(-70), deg_to_rad(90))

func _process(delta: float) -> void:
	camera_movement(delta)

func camera_movement(delta):
	if Input.is_action_pressed("go_left"):
		camera.rotation.z = lerp_angle(camera.rotation.z, 0.1, 0.1)
	elif Input.is_action_pressed("go_right"):
		camera.rotation.z = lerp_angle(camera.rotation.z, -0.1, 0.1)
	elif  !Input.is_action_pressed("go_right") and !Input.is_action_just_pressed("go_left"):
		camera.rotation.z = lerp_angle(camera.rotation.z, 0.0, 0.1)
