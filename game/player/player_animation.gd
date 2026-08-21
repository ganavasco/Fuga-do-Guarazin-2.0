extends Node

@export var player: Player
@export var animated_sprite: AnimatedSprite2D


func _process(_delta: float) -> void:
	if player.is_on_floor():
		animated_sprite.play("run")
	else:
		if player.velocity.y < 0:
			animated_sprite.play("up")
		else:
			animated_sprite.play("down")
