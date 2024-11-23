extends Node

@onready var conversion = $"UI/Сonversion/AnimationPlayer"
@onready var use_indicator: Control = $UI/UseIndicator
@onready var coins: Label = $UI/Coins

func _physics_process(delta: float) -> void: coins.text = "coins: " + str(global_var.coins)
