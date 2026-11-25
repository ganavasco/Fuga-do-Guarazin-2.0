extends State
class_name TuristaDash

var character : CharacterBody2D

func Enter():
	character = get_parent().character
	character.speed += 500.0
	#character.animation_p.play("DASH")

func Exit():
	pass

func Update(_delta : float):
	pass

func Physics_Update(_delta : float):
	pass
	#character.velocity = Vector2.ZERO
	#if Input.is_action_just_pressed("jump"):
	#	StartChase()
