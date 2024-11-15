extends CharacterBody3D

@export var NavAgent : NavigationAgent3D

var speed = 3.0

enum States {Idle, Wardering, Walk, Attack_}
enum Mob_Types {Light, Middle, Tank, Camicadze, Knight}

@export var Mob_Type = Mob_Types.Light
@export var Animator : AnimationPlayer
@export var target : Marker3D
@export var spawn_bullet_pos : Marker3D

var HP = 60

var purpose

@export var state = States.Idle

var load_bullet = preload("res://scenes/entity/bullet/bullet.tscn")


func _physics_process(delta: float) -> void:
	if purpose:
		target.global_position = purpose.global_position
	check_mob_type()
	change_state()
	move_and_slide()
	
func check_mob_type():
	if purpose:
		_look_at()

	
	
func change_state():
	var pos = global_position
	match state:
		States.Walk:
			NavAgent.set_target_position(target.global_position)
			var next_pos = NavAgent.get_next_path_position()
			velocity  = (next_pos - global_transform.origin).normalized() * speed
			Animator.play("walk")
			if self.global_position.distance_to(target.global_position) <= 10:
				state = States.Idle
		States.Idle:
			Animator.play("idle")
			velocity = Vector3(0, 0, 0)
			if self.global_position.distance_to(target.global_position) > 11:
				state = States.Walk
		States.Attack_:
			NavAgent.set_target_position(target.global_position)
			var next_pos = NavAgent.get_next_path_position()
			velocity  = (next_pos - global_transform.origin).normalized() * speed * 0.2
			Animator.play("attack")
			await Animator.animation_finished
			state = States.Idle


func _on_check_purpose_timeout() -> void:
	shooting()
func shooting():
	if purpose:
		if state != States.Attack_:
			if state == States.Idle or States.Walk:
				state = States.Attack_
func shoot():
	add_bullet()
	await get_tree().create_timer(0.5, false).timeout
	add_bullet()
	await get_tree().create_timer(0.5, false).timeout
	add_bullet()

func add_bullet():
	var scene = get_tree().root
	var bullet = load_bullet.instantiate()
	add_child(bullet)
	var dir = Vector3(0,0,-1,).rotated(Vector3.UP, global_rotation.y)
	bullet.speed = 100
	bullet._damage = 10
	bullet.delate_time = 5
	bullet.forwared_direction = dir
	bullet.global_position = spawn_bullet_pos.global_position
	bullet.global_rotation = spawn_bullet_pos.global_rotation
	bullet.reparent(scene)
			
	
	
func _look_at():
	var a = Quaternion(transform.basis)
	var po = target.global_position
	po.y = transform.origin.y
	var b = Quaternion(transform.looking_at(po, Vector3.UP).basis)
	var c = a.slerp(b, 0.2)
	transform.basis = Basis(c)
	
func _on_get_player_area_entered(area: Area3D) -> void:
	if area.get_parent() is MoveMent:
		state = States.Walk
		purpose = area.get_parent()
		
func damage():
	print("ай")
