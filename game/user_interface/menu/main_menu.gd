extends Node

@export_category("Trees")
@export var play_tree: PackedScene
@export var settings_tree: PackedScene

func _on_play_pressed() -> void: 
	get_tree().change_scene_to_file("res://scenes/levels/test/test_level.tscn")

func _on_settings_pressed() -> void:
	pass
