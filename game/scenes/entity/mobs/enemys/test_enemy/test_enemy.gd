extends CharacterBody3D

@export var NavAgent : NavigationAgent3D

var speed = 5.0

enum States {Idle, Wardering, Walk, Attack_}
enum Mob_Types {Light, Middle, Tank, Camicadze, Knight}

@export var Mob_Type = Mob_Types.Light
@export var Animator : AnimationPlayer
@export var target : Marker3D

var purpose

@export var state = States.Idle


func _physics_process(delta: float) -> void:
	if purpose:
		target.global_position = purpose.global_position
	check_mob_type()
	change_state()
	move_and_slide()
	
func check_mob_type():
	match Mob_Type:
		Mob_Types.Light:
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
