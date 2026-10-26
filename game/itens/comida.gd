extends Area2D

signal comeu(estamina_value : float)

@export var replenish_value : float = 50.0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		comeu.emit(replenish_value)
		queue_free()
