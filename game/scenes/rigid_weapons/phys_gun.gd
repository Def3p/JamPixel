extends RigidBody3D

@export var weapon_id: int

func impulse(vector: Vector3): apply_central_impulse(vector)

func interaction(weapon_manager): 
	weapon_manager.add_weapon(weapon_id)
	weapon_manager.current_weapon = weapon_id
	queue_free()
