extends Node

@onready var menu = $UI/Menu
@onready var conversion = $"UI/Сonversion/AnimationPlayer"
@onready var player_hud: Control = $"UI/2D"
@onready var fps: Label = $UI/FPS

func _process(delta: float) -> void: fps.text = str(Engine.get_frames_per_second())
