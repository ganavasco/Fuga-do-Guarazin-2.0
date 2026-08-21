extends Node

@export var player: Player
@export var jump_buffer: Timer

var jump_buffer_used = false	# for cases where player uses jump + fastfall right after


func _process(_delta: float) -> void:
	if jump_buffer.time_left > 0 and not jump_buffer_used:
		jump()


func jump() -> void:
	if player.is_on_floor():
		jump_buffer_used = true
		player.velocity += Vector2.UP * GameMode.features.player_jump_force


func _on_input_jump_pressed() -> void:
	jump_buffer.start()


func _on_jump_buffer_timeout() -> void:
	jump_buffer_used = false
