extends State
class_name TuristaRun

#@export var walk_speed : float = 200.0
@export var navigation_agent_2d: NavigationAgent2D

var player : PlayerTopView
var current_target : Node2D
var character : CharacterBody2D
var direction : Vector2
var anim_sprite : Sprite2D
var can_move : bool = false
var game_start : bool = false
var walk_speed : float

func Enter():
	player = get_tree().get_first_node_in_group("player")
	character = get_parent().character
	character.animation_p.play("CHASE")
	anim_sprite = character.sprite
	walk_speed = character.speed

func Exit():
	pass

func Update(_delta : float):
	pass

func Physics_Update(delta : float):
	navigation_agent_2d.target_position = character.target.global_position
	direction = character.global_position.direction_to(navigation_agent_2d.get_next_path_position())
	#print(direction)
	if (character.global_position.x - player.global_position.x) > 400:
		walk_speed = 75.0
	elif (character.global_position.x - player.global_position.x) > -400:
		walk_speed = 150
	else:
		can_move = true
		walk_speed = 300
	if navigation_agent_2d.is_target_reached() == false:
		if can_move and game_start:
			character.velocity = character.velocity.lerp(direction * walk_speed, delta)
		else: 
			character.velocity = character.velocity.lerp(Vector2.ZERO, delta)
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

func _on_navigation_agent_2d_link_reached(details: Dictionary) -> void:
	#print("link reached")
	get_parent().destination = details["link_exit_position"]
	transitioned.emit(self, "Jump")


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if character.global_position.x > player.global_position.x:
		can_move = false


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	can_move = true
