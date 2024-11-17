extends Node

@onready var menu = $UI/Menu
@onready var conversion = $"UI/Сonversion/AnimationPlayer"
@onready var fps: Label = $UI/FPS
@onready var use_indicator: Control = $UI/UseIndicator


func _ready() -> void: 
	menu.hide()
	fps.show()

func _process(delta: float) -> void: fps.text = str(Engine.get_frames_per_second())
