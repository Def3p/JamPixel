class_name MoveMent

extends CharacterBody3D

@export var _Health_Component : HealthComponent

@export var def_speed : float

var speed = 5.0
var JUMP_VELOCITY = 8

var want_jump = false
var wall_run = false

var parkour_dir

func _physics_process(delta: float) -> void:
	$"2D/FPS".text = str(Engine.get_frames_per_second())
	parkour_dir = Vector3(0, 0, -1).rotated(Vector3.UP, global_rotation.y)
	
	if not is_on_floor():
		if !wall_run:
			velocity += get_gravity() * delta * 2.5

	if Input.is_action_pressed("run") and Input.is_action_pressed("go_forward"):
		speed = 10.0
	else:
		speed = def_speed
		

	var input_dir := Input.get_vector("go_left", "go_right", "go_forward", "go_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = lerp(velocity.x, direction.x * speed * 1.2, 20 * delta)
		velocity.z = lerp(velocity.z, direction.z * speed * 1.2, 20 * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	move_and_slide()
