extends CharacterBody3D

@export var NavAgent : NavigationAgent3D

var speed = 2.0

enum States {Idle, Wardering, Walk, Attack_}
enum Mob_Types {Light, Middle, Tank, Camicadze, Knight, Sniper}

@export var Mob_Type = Mob_Types.Light
@export var Animator : AnimationPlayer
@export var target : Marker3D
@export var spawn_bullet_pos : Marker3D
@export var shoot_collider : RayCast3D
@export var detect_collider : RayCast3D

@export var blood_particle : GPUParticles3D
@export var shoot_particle : GPUParticles3D
@export var gun : Node3D

var HP = 50

var purpose
var possible_purpose

@export var state = States.Idle

var load_coin = preload("res://scenes/entity/coins/coin.tscn")
var load_bullet = preload("res://scenes/entity/bullet/bullet.tscn")
var load_bone = preload("res://scenes/entity/remains/bones/Bones.tscn")


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
			if self.global_position.distance_to(target.global_position) <= 15:
				state = States.Idle
		States.Idle:
			Animator.play("idle")
			velocity = Vector3(0, 0, 0)
			if self.global_position.distance_to(target.global_position) > 16:
				state = States.Walk
		States.Attack_:
			NavAgent.set_target_position(target.global_position)
			var next_pos = NavAgent.get_next_path_position()
			velocity  = (next_pos - global_transform.origin).normalized() * speed * 0.0
			Animator.play("attack")
			await Animator.animation_finished
			state = States.Idle


func _on_check_purpose_timeout() -> void:
	if shoot_collider.is_colliding() and shoot_collider.get_collider() is HitboxComponent:
		shooting()
func shooting():
	if purpose:
		if state != States.Attack_:
			if state == States.Idle or States.Walk:
				state = States.Attack_
func shoot():
	$timers/shoot_timer.start()
	await $timers/shoot_timer.timeout
	add_bullet()
	$timers/shoot_timer.stop()


func add_bullet():
	var scene = get_tree().root
	var bullet = load_bullet.instantiate()
	add_child(bullet)
	var dir = Vector3(0,0,-1,).rotated(Vector3.UP, global_rotation.y)
	bullet.speed = 15
	bullet._damage = 60
	bullet.delate_time = 2
	bullet.forwared_direction = dir
	bullet.global_position = spawn_bullet_pos.global_position
	bullet.global_rotation = spawn_bullet_pos.global_rotation
	shoot_particle.emitting = true
	bullet.reparent(scene)
			
	
	
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
