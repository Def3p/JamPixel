class_name WeaponManager
extends Node3D

enum states { IDLE, SHOOT, RELOAD }

@export var max_weapons: int = 2
@export var state: states
@export var start_weapon: Gun

var weapons_list = []
var available_weapons = []
var current_weapon: int = 0
var wheel_flag: bool = true
var last_weapon: int

@onready var weapons: Node3D = $WeaponsList
@onready var shoot_ray: RayCast3D = $ShootRaycast
@onready var interaction_ray: RayCast3D = $InteractionRaycast
@onready var wheel_timer: Timer = $WheelTimer

func _ready() -> void:
	for child in weapons.get_children(): if child is Gun: 
		weapons_list.append(child)
		child.hide()
	add_weapon(0)
	add_weapon(1)
	start_weapon.show()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interaction"): interaction()
	select_weapon()
	weapon_initialization()
	state_machine()


func select_weapon():
	if !wheel_flag: return
	if Input.is_action_just_pressed("select_up"): 
		current_weapon += 1
		wheel_timer.start()
		wheel_flag = false
	if Input.is_action_just_pressed("select_down"): 
		current_weapon -= 1
		wheel_timer.start()
		wheel_flag = false
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


func _on_wheel_timer_timeout() -> void:
	wheel_flag = true


func weapon_initialization():
	if last_weapon == current_weapon: return
	for weapon in available_weapons: weapon.hide()
	available_weapons[current_weapon].show()
	last_weapon = current_weapon


func state_machine():
	if state == states.IDLE:
		pass

	if state == states.SHOOT:
		pass

	if state == states.RELOAD:
		pass
