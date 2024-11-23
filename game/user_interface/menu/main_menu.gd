extends Node

@export_category("Trees")
@export var play_tree: PackedScene
@export var settings_tree: PackedScene

@onready var settings_menu: MarginContainer = %SettingsMenu

@onready var exit_confirm: MarginContainer = %ExitConfirm
@onready var yes_exit_button: Button = %YesExitConfirmButton
@onready var no_exit_button: Button = %NoExitConfirmButton

@onready var play = $Buttons/VBoxButtons/Button
@onready var settings = $Buttons/VBoxButtons/Button2


func _enter_tree() -> void: HUD.hide()


func _ready():
	exit_confirm.hide()
	settings_menu.hide()
	
	yes_exit_button.pressed.connect(func():
		get_tree().quit()
	)
	
	no_exit_button.pressed.connect(func():
		exit_confirm.hide()
	)
	
	play.pressed.connect(_on_play_pressed)
	settings.pressed.connect(_on_settings_pressed)


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		exit_confirm.visible = not exit_confirm.visible


func _on_play_pressed() -> void: 
	get_tree().change_scene_to_file("res://scenes/levels/zone_0/zone_0.tscn")

func _on_settings_pressed() -> void:
	settings_menu.visible = not settings_menu.visible
