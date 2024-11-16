extends CanvasLayer

@onready var time_to_auto_respawn = %"time to autorespawn"
@onready var auto_respawn_timer = $Timer

var def_scene = "res://scenes/levels/test/test_level.tscn"

func _process(delta: float) -> void:
	time_to_auto_respawn.text = str(round(auto_respawn_timer.time_left))


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file(def_scene)
