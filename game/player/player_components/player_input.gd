extends Node

signal jump_pressed
signal fastfall_pressed

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump"):
		jump_pressed.emit()
	if Input.is_action_just_pressed("fall"):
		fastfall_pressed.emit()
