extends MarginContainer

# AUDIO
@onready var master_h_slider: HSlider = %MasterHSlider
@onready var music_h_slider: HSlider = %MusicHSlider
@onready var effects_h_slider: HSlider = %EffectsHSlider

@onready var resolution_option_button: OptionButton = %SizeOptionButton

var window_sizes: Array = [
	Vector2i(1200, 720),
	Vector2i(1152, 648),
	#Vector2i(1200, 720),
]

func _ready() -> void:
	window_sizes.push_front(DisplayServer.screen_get_size())
	
	for s in window_sizes:
		resolution_option_button.add_item(str(s.x)+"x"+str(s.y))
	
	resolution_option_button.item_selected.connect(func(item):
		var target_resoulution = window_sizes[item]
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_size(target_resoulution)
		#await get_tree().process_frame
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	)
	
	master_h_slider.value_changed.connect(set_bus_volume.bind(0))
	music_h_slider.value_changed.connect(set_bus_volume.bind(1))
	effects_h_slider.value_changed.connect(set_bus_volume.bind(2))


func set_bus_volume(volume, bus):
	AudioServer.set_bus_volume_db(bus, volume)
	print_debug(AudioServer.get_bus_name(bus), " ", AudioServer.get_bus_volume_db(bus))
