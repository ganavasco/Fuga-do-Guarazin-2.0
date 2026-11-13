extends CharacterBody2D

@export var target : Node2D
@export var animation_p : AnimationPlayer
@export var sprite : Sprite2D
@export var collision : CollisionShape2D
@export var run_node : Node2D

func _ready() -> void:
	disable_movement()

func enable_movement() -> void:
	if run_node:
		run_node.can_move = true
		run_node.game_start = true

func disable_movement() -> void:
	print("disabled_called")
	if run_node:
		print("disabled")
		run_node.can_move = false
		run_node.game_start = false

func update_target(new_target):
	target = new_target
	if run_node:
		run_node.current_target = new_target
