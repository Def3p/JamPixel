class_name HealthComponent
extends Node3D

signal death

@export var max_health: float = 100

var health: float

func _ready(): health = max_health

func damage(attack: Attack) -> void:
	health -= attack.damage
	print(health)

	if health <= 0:
		death.emit()
