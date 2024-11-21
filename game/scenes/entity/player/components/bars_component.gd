extends Node

@export var Health_Component : HealthComponent
@export var Move_Ment : MoveMent

@onready var health_bars = [%green, %green2, %green3, %green4, %green5]
@onready var stamine_bars = [%blue, %blue2, %blue3, %blue4, %blue5, %blue6, %blue7, %blue8]

func _process(delta: float) -> void:
	update_health_bars()
	update_stamina_bars()
	
func update_health_bars() -> void:
	for i in range(health_bars.size()):
		if i < Health_Component.health:
			health_bars[i].show()
		else:
			health_bars[i].hide()

func update_stamina_bars():
	for i in range(stamine_bars.size()):
		if Move_Ment.stamine % 10 == 0:
			var a = Move_Ment.stamine / 10
			if i < a:
				stamine_bars[i].show()
			else:
				stamine_bars[i].hide()
