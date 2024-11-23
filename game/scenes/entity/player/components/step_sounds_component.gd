class_name Step_Sounds_Component

extends Node

@export var def_step_sound : AudioStreamPlayer3D
@export var floor_collider : RayCast3D
@export var timer : Timer

func stepping(play_cd : float):
	if floor_collider.is_colliding():
		if timer.is_stopped():
			timer.start(play_cd)
			def_step_sound.play()
			await timer.timeout
			timer.stop()
		
