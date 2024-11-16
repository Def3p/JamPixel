class_name MainMenu
extends Node

@export_category("Trees")
@export var play_tree: PackedScene
@export var settings_tree: PackedScene

@onready var buttons = $UI/Menu/VBoxButtons

func _on_play_pressed() -> void: global_var.lobby.change_camera(2)

func _on_settings_pressed() -> void:
	pass

func _on_exit_pressed() -> void: pass
