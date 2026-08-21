extends Node

@export var player: Player


func _physics_process(delta: float) -> void:
	fall(delta)
	#player.velocity *= Vector2.DOWN	# nulls horizontal velocity
	player.move_and_slide()


func fall(delta) -> void:
	var gravity_direction = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
	var gravity_magnitude = ProjectSettings.get_setting("physics/2d/default_gravity")
	player.velocity += gravity_direction * gravity_magnitude * delta
