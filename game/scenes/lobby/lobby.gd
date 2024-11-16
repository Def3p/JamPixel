extends CameraController

@onready var menu: Control = $CanvasLayer/Menu


func _physics_process(delta: float) -> void:
	if current_camera == 0: 
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		global_ui.menu.hide()
	elif current_camera == 1: 
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		global_ui.menu.show()
