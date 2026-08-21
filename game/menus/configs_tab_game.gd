extends MarginContainer


func _on_back_to_menu_pressed() -> void:
	get_tree().paused = false
	MainSingleton.go_to_menu()


func _on_exit_configs_pressed() -> void:
	get_tree().paused = false
	visible = false


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause") and visible:
		await get_tree().create_timer(0.01).timeout
		get_tree().paused = false
		visible = false
