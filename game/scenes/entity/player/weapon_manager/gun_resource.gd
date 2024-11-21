class_name Gun
extends Node3D

@export var weapon_name: String
@export var is_cast: bool

@export_category("Ammo")
@export var max_ammo: int
@export var amount_ammo: int
@export var infinity: bool = false
@export var is_reload: bool = true

@export_category("Raycast")
@export var length: float = 35.0
@export var damage : float

@export_category("Load Nodes")
@export var animator: AnimationPlayer
@export var cast_weapon: PackedScene
