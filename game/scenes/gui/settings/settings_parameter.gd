@tool
extends HBoxContainer

@onready var label: Label = %Label

@export_multiline var setting_text: String:
	set(value):
		setting_text = value
		if not is_node_ready() and not Engine.is_editor_hint(): await ready
		label.text = setting_text

func _ready() -> void:
	label.text = setting_text
