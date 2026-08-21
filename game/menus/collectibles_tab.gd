extends MarginContainer

@export var entries_vbox: VBoxContainer


func _ready() -> void:
	load_collectibles()


func load_collectibles() -> void:
	for collectible_scene in MainSingleton.unlocked_entries:
		var entry = collectible_scene.instantiate()
		entries_vbox.add_child(entry)


func _on_exit_button_pressed() -> void:
	visible = false


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		visible = false
