class_name ParkourComponent

extends Node

@export var _MovementComponent : MoveMent

@onready var wall_raycasts = [$"../../WallHitbox/left_raycast", $"../../WallHitbox/right_raycast"]

var want_running_on_wall = false


func _on_wall_hitbox_area_entered(area: Area3D) -> void:
	if area is HitboxComponent and area.type == "wall":
		want_running_on_wall = true 
		

func _on_wall_hitbox_area_exited(area: Area3D) -> void:
	
	want_running_on_wall = false
		
		
func _process(delta: float) -> void:
	run_on_wall(delta)
		
func run_on_wall(delta):
	if want_running_on_wall:
		if Input.is_action_pressed("go_forward") and Input.is_action_pressed("go_left") or Input.is_action_pressed("go_right"):
			_MovementComponent.wall_run = true
			_MovementComponent.velocity += _MovementComponent.get_gravity() * delta * 1
		if Input.is_action_just_pressed("jump"):
			for i in wall_raycasts:
				if i.is_colliding():
					if wall_raycasts[0].is_colliding():
						_MovementComponent.velocity.x = move_toward(_MovementComponent.velocity.x, 0, 60)
						_MovementComponent.velocity.y = 10
					elif wall_raycasts[1].is_colliding():
						_MovementComponent.velocity.y = 10
						_MovementComponent.velocity.x = move_toward(_MovementComponent.velocity.x, 0, -60)
						
	else:
		_MovementComponent.wall_run = false
