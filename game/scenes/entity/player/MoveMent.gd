class_name MoveMent

extends CharacterBody3D

@export var _Health_Component : HealthComponent

@export var def_speed : float
@export var kayot_timer : Timer
@export var stamine_timer : Timer
@export var stamine_reload : Timer

var speed = 5.0
var JUMP_VELOCITY = 8
var stamine = 80
var going = false
var runing = false

var want_jump = false
var wall_run = false

var parkour_dir

func _physics_process(delta: float) -> void:
	stamine_logic()
	parkour_dir = Vector3(0, 0, -1).rotated(Vector3.UP, global_rotation.y)
	
	if not is_on_floor():
		if !wall_run:
			velocity += get_gravity() * delta * 3

	if Input.is_action_pressed("run") and !Input.is_action_pressed("go_back") and stamine > 0:
		speed = 10.0
		runing = true
	else:
		speed = def_speed
		runing = false
		
	var input_dir := Input.get_vector("go_left", "go_right", "go_forward", "go_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = lerp(velocity.x, direction.x * speed * 1.2, 20 * delta)
		velocity.z = lerp(velocity.z, direction.z * speed * 1.2, 20 * delta)
		going = true
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		going = false
	if is_on_floor() and !want_jump:
		want_jump = true
	elif want_jump and kayot_timer.is_stopped():
		kayot_timer.start(0.1)
		
	if want_jump:
		if Input.is_action_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
	move_and_slide()

func _on_kayot_jump_timeout() -> void:
	want_jump = false

func stamine_logic():
	if stamine_timer.is_stopped() and going and runing:
		if stamine > 0:
			stamine_timer.start()
			stamine -= 1
			if stamine == 0:
				stamine = -20
			await stamine_timer.timeout
			stamine_timer.stop()
	if stamine <= 0:
		if stamine_timer.is_stopped():
			stamine_timer.start()
			if stamine == 0:
				stamine = 10
			await stamine_timer.timeout
			stamine_timer.stop()
	if stamine < 80 and !runing:
		if stamine_reload.is_stopped():
			stamine_reload.start()
			stamine += 1
			await stamine_reload.timeout
			stamine_reload.stop()
			#020
			
			
			
