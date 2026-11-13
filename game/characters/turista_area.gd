extends Area2D

@export var new_target : Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("turista"):
		if new_target:
			body.update_target(new_target)
