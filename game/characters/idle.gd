extends State
class_name EnemyIdle

var character : CharacterBody2D

func Enter():
	character = get_parent().character
	character.animation_p.play("IDLE")

func Exit():
	pass

func Update(_delta : float):
	pass

func Physics_Update(_delta : float):
	character.velocity = Vector2.ZERO

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		character.target = body
		transitioned.emit(self, "Chase")
