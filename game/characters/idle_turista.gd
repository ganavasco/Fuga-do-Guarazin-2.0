extends State
class_name TuristaIdle

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
	if Input.is_action_just_pressed("jump"):
		StartChase()

func StartChase():
	transitioned.emit(self, "Run")
