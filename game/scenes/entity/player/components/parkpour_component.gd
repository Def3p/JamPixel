class_name ParkourComponent

extends Node

@export var _MovementComponent : MoveMent

@onready var wall_raycasts = [$"../../WallHitbox/left_raycast", $"../../WallHitbox/left_raycast2", $"../../WallHitbox/left_raycast3", $"../../WallHitbox/right_raycast", $"../../WallHitbox/right_raycast2", $"../../WallHitbox/right_raycast3"]
@onready var directions = [$"../../WallHitbox/left", $"../../WallHitbox/right"]

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
		if Input.is_action_just_pressed("go_forward"):
			_MovementComponent.wall_run = true
			_MovementComponent.velocity += _MovementComponent.get_gravity() * delta * 0.5
		if Input.is_action_pressed("jump"):
			for i in wall_raycasts:
				if i.is_colliding():
					if wall_raycasts[0].is_colliding() or wall_raycasts[1].is_colliding() or wall_raycasts[2].is_colliding():
						var parkour_dir = Vector3(0, 0, -1).rotated(Vector3.UP, directions[0].global_rotation.y)
						var forward_direction = parkour_dir.normalized()
						_MovementComponent.velocity = forward_direction * 200 * delta * 20
						_MovementComponent.velocity.y = 20
					elif wall_raycasts[3].is_colliding() or wall_raycasts[4].is_colliding() or wall_raycasts[5].is_colliding():
						var parkour_dir = Vector3(0, 0, -1).rotated(Vector3.UP, directions[1].global_rotation.y)
						var forward_direction = parkour_dir.normalized()
						_MovementComponent.velocity = forward_direction * 200 * delta * 20
						_MovementComponent.velocity.y = 20
	else:
		_MovementComponent.wall_run = false
