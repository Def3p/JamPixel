extends Node

@export_category("Trees")
@export var play_tree: PackedScene
@export var settings_tree: PackedScene


@onready var exit_confirm: MarginContainer = %ExitConfirm
@onready var yes_exit_button: Button = %YesExitConfirmButton
@onready var no_exit_button: Button = %NoExitConfirmButton


func _ready():
	exit_confirm.hide()
	
	yes_exit_button.pressed.connect(func():
		get_tree().quit()
	)
	
	no_exit_button.pressed.connect(func():
		exit_confirm.hide()
	)


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		exit_confirm.visible = not exit_confirm.visible


func _on_play_pressed() -> void: 
	get_tree().change_scene_to_file("res://scenes/levels/test/test_level.tscn")

func _on_settings_pressed() -> void:
	pass
