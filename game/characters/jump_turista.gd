extends State
class_name TuristaJump

@export var jump_timer : Timer
@export var jump_speed : float = 200.0

var character : CharacterBody2D
var col : CollisionShape2D
var dir : Vector2

func Enter():
	print("Entered jump")
	character = get_parent().character
	character.animation_p.play("JUMP")
	col = character.collision
	col.set_deferred("disabled", true)
	#jump_timer.start()
	dir = character.global_position.direction_to(get_parent().destination).normalized()
	character.velocity = Vector2.ZERO
	
func Exit():
	print("Exited jump")
	pass

func Update(_delta : float):
	pass

func Physics_Update(delta : float):
	#print(character.velocity)
	if (character.global_position - get_parent().destination).length() < 10.0:
		col.set_deferred("disabled", false)
		transitioned.emit(self, "Run")
	character.velocity = character.velocity.lerp(dir * jump_speed, delta)
	#character.velocity = Vector2.ZERO
	character.move_and_slide()

#func _on_jump_timer_timeout() -> void:
#	col.set_deferred("disabled", false)
#	transitioned.emit(self, "Run")
