extends Node

@export var player: Player

var fastfall_buffer: bool = true


func _process(_delta: float) -> void:
	if player.is_on_floor():
		fastfall_buffer = true


func fastfall() -> void:
	if not player.is_on_floor() and fastfall_buffer:
		# kill momentum and apply force
		player.velocity = Vector2.DOWN * GameMode.features.player_jump_force
		fastfall_buffer = false
