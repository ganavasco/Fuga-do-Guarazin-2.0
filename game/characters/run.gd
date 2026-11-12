extends State
class_name TuristaRun

@export var walk_speed : float = 200.0
@export var navigation_agent_2d: NavigationAgent2D

var current_target : Node2D
var character : CharacterBody2D
var direction : Vector2
var anim_sprite : Sprite2D

func Enter():
	character = get_parent().character
	character.animation_p.play("CHASE")
	anim_sprite = character.sprite

func Exit():
	pass

func Update(_delta : float):
	pass

func Physics_Update(delta : float):
	navigation_agent_2d.target_position = character.target.global_position
	direction = character.global_position.direction_to(navigation_agent_2d.get_next_path_position())
	print(direction)
	
	if navigation_agent_2d.is_target_reached() == false:
		character.velocity = character.velocity.lerp(direction * walk_speed, delta)
	else:
		transitioned.emit(self, "Idle")
	#var target_position = character.target.global_position
	#if target_position != null:
	#	direction = target_position - character.global_position
	#	character.velocity = direction.normalized() * walk_speed
	#else: 
	#	direction = Vector2.ZERO
	update_animation()
	character.move_and_slide()

func update_animation():
	if direction != Vector2.ZERO:
		if direction.x != 0:
			anim_sprite.flip_h = (direction.x < 0)

#func _on_area_2d_body_exited(body: Node2D) -> void:
#	if body.is_in_group("player"):
#		transitioned.emit(self, "Idle")
#		current_target = null
