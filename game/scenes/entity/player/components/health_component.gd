class_name HealthComponent

extends Node

@export var max_health : float
var health

func _ready() -> void:
	health = max_health

func damage(_damage : float) -> void:
	health -= _damage
	
func check_hp():
	if health <= 0:
		pass

func _on_timer_timeout() -> void:
	check_hp()
