extends StaticBody3D

@export var weapon_name: String
@export var money: int

func interaction(wm: WeaponManager):
	if global_var.coins >= money:
		wm.add_weapon(weapon_name)
		global_var.coins -= money
