extends CharacterBody3D

@export var NavAgent : NavigationAgent3D

var speed = 3.0

enum States {Idle, Wardering, Walk, Attack_}
enum Mob_Types {Light, Middle, Tank, Camicadze, Knight, Sniper}

@export var Mob_Type = Mob_Types.Light
@export var Animator : AnimationPlayer
@export var target : Marker3D
@export var spawn_bullet_pos : Marker3D
@export var attack_collider : RayCast3D
@export var detect_collider : RayCast3D

@export var blood_particle : GPUParticles3D
@export var shoot_particle : GPUParticles3D
@export var gun : Node3D

var HP = 300

var purpose
var possible_purpose

@export var state = States.Idle

var load_bone = preload("res://scenes/entity/remains/bones/Bones.tscn")
var load_coin = preload("res://scenes/entity/coins/coin.tscn")


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta * 2.5
	if purpose:
		target.global_position = purpose.global_position
	check_mob_type()
	change_state()
	move_and_slide()
	detect_player()
	
func check_mob_type():
	if purpose or possible_purpose:
		_look_at()

func change_state():
	var pos = global_position
	match state:
		States.Walk:
			NavAgent.set_target_position(target.global_position)
			var next_pos = NavAgent.get_next_path_position()
			velocity  = (next_pos - global_transform.origin).normalized() * speed
			Animator.play("walk")
			if self.global_position.distance_to(target.global_position) <= 1:
				state = States.Idle
		States.Idle:
			Animator.play("idle")
			velocity = Vector3(0, 0, 0)
			if self.global_position.distance_to(target.global_position) > 2:
				state = States.Walk
		States.Attack_:
			NavAgent.set_target_position(target.global_position)
			var next_pos = NavAgent.get_next_path_position()
			velocity  = (next_pos - global_transform.origin).normalized() * speed * 0.0
			Animator.play("attack")
			await Animator.animation_finished
			state = States.Idle


func _on_attack_area_area_entered(area: Area3D) -> void:
	if purpose:
		if state != States.Attack_:
			if state == States.Idle or States.Walk:
				state = States.Attack_
func attack():
	if attack_collider.is_colliding() and attack_collider.get_collider() is HitboxComponent:
		attack_collider.get_collider().get_parent()._Health_Component.damage(2)
		attack_collider.get_collider().get_parent().velocity = attack_collider.get_collider().get_parent().parkour_dir * -100
		attack_collider.get_collider().get_parent().velocity.y += 10
		
func _look_at():
	if purpose:
		var a = Quaternion(transform.basis)
		var po = target.global_position
		po.y = transform.origin.y
		var b = Quaternion(transform.looking_at(po, Vector3.UP).basis)
		var c = a.slerp(b, 0.2)
		transform.basis = Basis(c)
	if possible_purpose:
		detect_collider.look_at(possible_purpose.global_position)
		
func detect_player():
	if detect_collider.is_colliding() and detect_collider.get_collider() is HitboxComponent and possible_purpose:
		purpose = detect_collider.get_collider().get_parent()
		state = States.Walk
		possible_purpose = null
		
func _on_get_player_area_entered(area: Area3D) -> void:
	if !possible_purpose:
		if area.get_parent() is MoveMent:
			possible_purpose = area.get_parent()
		
func damage(damage):
	blood_particle.emitting = true
	HP -= damage

func _on_check_died_timeout() -> void:
	died()
		
func died():
	if HP <= 0:
		var scene = get_tree().root
		var coin = load_coin.instantiate()
		var bones = load_bone.instantiate()
		add_child(coin)
		add_child(bones)
		coin.reparent(scene)
		bones.reparent(scene)
		self.queue_free()
