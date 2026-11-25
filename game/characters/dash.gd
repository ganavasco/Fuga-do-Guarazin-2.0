extends State
class_name TuristaDash

signal dash_exit

@export var dash_timer : Timer 
@export var dash_distance : float = 200.0

var character : CharacterBody2D
var initial_position_x : float

func Enter():
	character = get_parent().character
	character.set_collision_mask_value(2, false)
	#character.position.x += 200.0
	initial_position_x = character.global_position.x
	dash_timer.start()
	#character.animation_p.play("DASH")

func Exit():
	character.set_collision_mask_value(2, true)
	dash_exit.emit()

func Update(_delta : float):
	pass

func Physics_Update(delta : float):
	if (character.global_position.x - initial_position_x) < dash_distance:
		character.global_position.x += dash_distance * delta * 2
	else:
		transitioned.emit(self, "Run")
	#character.velocity.x = 500.0

func _on_timer_timeout() -> void:
	pass
	#transitioned.emit(self, "Run")
