class_name CameraController
extends Node

var current_camera: int = 0
var last_count_camera: int = 0

@export var camera_list: Array[Camera3D]

func _ready() -> void: init_camera(true)


func _process(delta: float) -> void: 
	init_camera()


func change_camera(count_camera: int): current_camera = count_camera


func init_camera(ready = false):
	if !ready: if last_count_camera == current_camera: return
	var last_camera = camera_list[last_count_camera]
	var get_camera = camera_list[current_camera]
	last_camera.current = false
	get_camera.current = true
	last_count_camera = current_camera
