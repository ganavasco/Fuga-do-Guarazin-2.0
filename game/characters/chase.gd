extends State
class_name EnemyChase

@export var walk_speed : float = 200.0


var current_target : CharacterBody2D
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

func Physics_Update(_delta : float):
	var target_position = character.target.global_position
	if target_position != null:
		direction = target_position - character.global_position
		character.velocity = direction.normalized() * walk_speed
	else: 
		direction = Vector2.ZERO
	update_animation()
	character.move_and_slide()

func update_animation():
	if direction != Vector2.ZERO:
		if direction.x != 0:
			anim_sprite.flip_h = (direction.x < 0)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		transitioned.emit(self, "Idle")
		current_target = null
