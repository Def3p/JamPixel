class_name HealthComponent

extends Node

@export var max_health : float
@onready var died_screen = $"../../2D/died_screen"
@onready var died_anim = $"../../2D/AnimationPlayer"
var died_screen_scene = "res://scenes/gui/died_screen/died_screen.tscn"
var health

func _ready() -> void:
	health = max_health

func damage(_damage : float) -> void:
	health -= _damage
func check_hp():
	if health <= 0:
		died_screen.show()
		died_anim.play("died_anim")
		await died_anim.animation_finished
		get_tree().change_scene_to_file.bind(died_screen_scene).call_deferred()
		
		
func _process(delta: float) -> void:
	check_hp()
