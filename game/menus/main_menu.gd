extends Node

@export var credits_tab: Control
@export var configs_tab: Control
@export var collectibles_tab: Control


func _on_start_pressed() -> void:
	MainSingleton.go_to_intro()


func _on_configs_pressed() -> void:
	configs_tab.visible = true

func _on_exit_configs_pressed() -> void:
	configs_tab.visible = false


func _on_credits_pressed() -> void:
	credits_tab.visible = true

func _on_exit_credits_pressed() -> void:
	credits_tab.visible = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause") and credits_tab.visible:
		credits_tab.visible = false


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_collectibles_pressed() -> void:
	collectibles_tab.visible = true
