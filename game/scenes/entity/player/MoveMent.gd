class_name MoveMent

extends CharacterBody3D

@export var def_speed : float

var speed = 5.0
var JUMP_VELOCITY = 6

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta * 2

	if Input.is_action_pressed("run") and Input.is_action_pressed("go_forward"):
		speed = 10.0
	else:
		speed = def_speed
		

	var input_dir := Input.get_vector("go_left", "go_right", "go_forward", "go_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	move_and_slide()
