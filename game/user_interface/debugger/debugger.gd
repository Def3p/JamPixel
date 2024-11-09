class_name DebugMenu
extends Control

var is_debug = false

var label_data: Array = []
var label_list: Array[Node] = []
var ready_label_names: Array[String] = []

func _ready() -> void:
	for child in %VBoxContainer.get_children():
		label_list.append(child)
	for label in label_list:
		ready_label_names.append(label.text)
	label_data = range(0, len(label_list) - 1)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("open_debug_menu"): is_debug = !is_debug
	self.visible = is_debug


func data_initialization(label_number: int, input_data):
	label_list[label_number].text = ready_label_names[label_number]
	label_list[label_number].text += str(input_data)
