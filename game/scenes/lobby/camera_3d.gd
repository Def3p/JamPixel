class_name PlayerChair
extends Node3D

var mouse_sens: float = 0.1
var is_tab: bool = false
var tab_rotation_y: float = 125.6
var tab_rotation_x: float = -2.0

@onready var head: Node3D = $Head
@onready var interaction_ray: RayCast3D = $Head/Camera3D/Interaction
@onready var tab_marker: Marker3D = $"../../Lobby_test/Marker3D"
@onready var camera: Camera3D = $Head/Camera3D
@onready var sub_viewport: SubViewport = $"../../../SubViewport"
@onready var lobby: Node = $"../../.."

func _input(event):
	if is_tab: return
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		rotation.y = clamp(rotation.y, deg_to_rad(-40), deg_to_rad(140))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-50), deg_to_rad(20))


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interaction"):
		if interaction_ray.get_collider() is HitboxComponent:
			interaction_ray.get_collider().get_parent().interaction(self)

	if !is_tab: return
	rotation.y = lerp(rotation.y, deg_to_rad(tab_rotation_y), 1.5 * delta)
	head.rotation.x = lerp(head.rotation.x, deg_to_rad(tab_rotation_x), 1.5 * delta)
	camera.fov = lerp(camera.fov, 22.0, 2.5 * delta)
	if rotation.y - tab_rotation_y > 1 or rotation.y - tab_rotation_y < 3:
		if head.rotation.x - tab_rotation_x > 3 or head.rotation.x - tab_rotation_x < 3:
			if camera.fov - 22.0 < 3:
				global_ui.conversion.play("black")
				global_ui.conversion.animation_finished.connect(animation_finished)


func animation_finished(anim_name: StringName) -> void:
	if anim_name == "black": 
		is_tab = false
		lobby.change_camera(1)
		global_ui.conversion.play("white")
