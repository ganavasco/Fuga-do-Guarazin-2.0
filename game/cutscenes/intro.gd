extends Node2D


func _ready() -> void:
	$AnimationPlayer.play("intro")


func _input(event):
	if event is InputEventKey:
		if event.pressed:
			MainSingleton.go_to_stage()


func finish() -> void:
	MainSingleton.go_to_stage()
