extends RigidBody3D

@export var weapon_name: String

func impulse(vector: Vector3): apply_central_impulse(vector)

func interaction(weapon_manager): 
	weapon_manager.add_weapon(weapon_name)
	weapon_manager.current_weapon += 1
	queue_free()
