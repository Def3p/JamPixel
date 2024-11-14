class_name WeaponManager
extends Node3D

enum states { CHANGE, IDLE, SHOOT, RELOAD }

@export var max_weapons: int = 2
@export var state: states
@export var start_weapon: Gun

var weapons_list = []
var available_weapons = []
var current_weapon: int = 0
var last_weapon: int = -1

@onready var weapons: Node3D = $WeaponsList
@onready var shoot_ray: RayCast3D = $ShootRaycast
@onready var interaction_ray: RayCast3D = $InteractionRaycast

func _ready() -> void:
	for child in weapons.get_children(): if child is Gun: 
		if child.max_ammo < child.amount_ammo: 
			child.amount_ammo = child.max_ammo
		weapons_list.append(child)
		child.hide()
	available_weapons.append(start_weapon)
	state = states.CHANGE


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interaction"): interaction()
	#if Input.is_action_just_pressed("shoot"): shoot()
	select_weapon()
	weapon_initialization()
	state_machine()


func select_weapon():
	if state == states.CHANGE: return 
	if Input.is_action_just_pressed("select_up"): 
		current_weapon += 1
	if Input.is_action_just_pressed("select_down"): 
		current_weapon -= 1
	if current_weapon > len(available_weapons) - 1: current_weapon = 0
	if current_weapon < 0: 
		if len(available_weapons) <= 1: current_weapon = 0
		else: current_weapon = 1


func interaction():
	if interaction_ray.is_colliding() and interaction_ray.get_collider() is HitboxComponent:
		interaction_ray.get_collider().get_parent().interaction(self)


func add_weapon(id: int):
	if len(available_weapons) >= max_weapons: return
	available_weapons.append(weapons_list[id])


func weapon_initialization():
	if last_weapon == current_weapon: return
	for weapon in available_weapons: weapon.hide()
	var get_gun = available_weapons[current_weapon]
	get_gun.animator.animation_finished.connect(animation_finished)
	get_gun.show()
	last_weapon = current_weapon


func state_machine():
	if state == states.IDLE:
		var get_gun = available_weapons[current_weapon]
		if Input.is_action_pressed("shoot"): 
			if get_gun.infinity: state = states.SHOOT
			elif get_gun.amount_ammo > 1: state = states.SHOOT
		if Input.is_action_just_pressed("reload"):
			state = states.RELOAD

	if state == states.CHANGE:
		var get_gun = available_weapons[current_weapon]
		get_gun.animator.play("change")

	if state == states.SHOOT:
		var get_gun = available_weapons[current_weapon]
		get_gun.animator.play("shoot")

	if state == states.RELOAD:
		var get_gun = available_weapons[current_weapon]
		get_gun.animator.play("reload")


func shoot():
	var get_gun = available_weapons[current_weapon]
	if !get_gun.infinity: available_weapons[current_weapon].amount_ammo -= 1
	if shoot_ray.is_colliding() and shoot_ray.get_collider() is HitboxComponent:
		pass # shoot_ray.get_collider()... выстрел

	get_gun.animator.play("shoot")

func animation_finished(_anim):
	state = states.IDLE
