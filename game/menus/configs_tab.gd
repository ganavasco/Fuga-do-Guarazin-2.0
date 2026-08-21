extends MarginContainer

var preferences = ConfigFile.new()
@export var music_slider: HSlider
@export var vfx_slider: HSlider


func _on_exit_configs_pressed() -> void:
	get_tree().paused = false
	visible = false


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		visible = false


func _ready() -> void:
	_load_preferences()


func _on_music_slider_drag_ended(_value_changed: bool) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("BGM"),
		linear_to_db(music_slider.value)
	)
	preferences.set_value("music", "volume", music_slider.value)
	preferences.save("user://preferences.cfg")

func _on_sfx_slider_drag_ended(_value_changed: bool) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("SFX"),
		linear_to_db(vfx_slider.value)
	)
	preferences.set_value("sfx", "volume", vfx_slider.value)
	preferences.save("user://preferences.cfg")


func _load_preferences():
	# Copied from raccoon days
	var err = preferences.load("user://preferences.cfg")
	if err == OK:
		if preferences.get_value("music", "volume"):
			music_slider.value = preferences.get_value("music", "volume")
		if preferences.get_value("sfx", "volume"):
			vfx_slider.value = preferences.get_value("sfx", "volume")
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("BGM"),
		linear_to_db(music_slider.value)
	)
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("SFX"),
		linear_to_db(vfx_slider.value)
	)
