extends CharacterBody3D

@export var NavAgent : NavigationAgent3D

var speed = 5.0

enum States {Idle, Wardering, Walk, Attack_}

@onready var target = $Node3D

var player

@export var state = States.Idle


func _physics_process(delta: float) -> void:
	if player:
		target.global_position = player.global_position
	velocity = Vector3.ZERO
	var pos = global_position
	match state:
		States.Walk:
			NavAgent.set_target_position(target.global_position)
			var next_pos = NavAgent.get_next_path_position()
			velocity  = (next_pos - global_transform.origin).normalized() * speed
			_look_at()
			$AnimationPlayer.play("walk_anim")
		States.Idle:
			velocity = Vector3(0, 0, 0)
	move_and_slide()
	
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
		player = area.get_parent()
