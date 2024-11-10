extends Node

@onready var buttons = $Menu/VBoxButtons

func _on_play_pressed() -> void: pass

func _on_settings_pressed() -> void:
	buttons.visible = buttons.visible
	

#func _on_exit_pressed() -> void: get_tree().quit()
