class_name PlayerTopView
extends CharacterBody2D

signal GameOver

@export var SPEED : float = 100.0
@export var anim_player : AnimationPlayer
@export var sprite : Sprite2D

@onready var collision : CollisionShape2D = $CollisionShape2D
@onready var timer : Timer = $JumpTimer
@onready var camera : Camera2D = $Camera2D

var direction : Vector2 = Vector2.ZERO
var last_direction : String = "RIGHT"
var mid_jump : bool = false
var game_over_called : bool = false
var can_move = true

func _ready() -> void:
	anim_player.play("IDLE")
	game_over_called = false

func _physics_process(delta: float) -> void:
	if game_over_called:
		anim_player.play("IDLE")
		return
	if can_move:
		position += direction * SPEED * delta
		update_animation()
	move_and_slide()

func update_animation():
	if mid_jump:
		if anim_player.current_animation != "JUMP":
			anim_player.play("JUMP")
		if direction.x != 0:
			sprite.flip_h = (direction.x < 0)
			#await anim_player.animation_finished
			#_on_jump_timer_timeout()
	elif direction != Vector2.ZERO:
		if direction.x != 0:
			sprite.flip_h = (direction.x < 0)
		if anim_player.current_animation != "WALK":
			anim_player.play("WALK")
	else:
		if anim_player.current_animation != "IDLE":
			anim_player.play("IDLE")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_type():
		direction.x = Input.get_axis("left", "right")
		direction.y = Input.get_axis("up", "down")
		direction = direction.normalized()
		if Input.is_action_pressed("jump") and not mid_jump:
			mid_jump = true
			collision.disabled = true
			timer.start()



func _on_jump_timer_timeout() -> void:
	collision.disabled = false
	mid_jump = false

func use_camera(flag : bool):
	camera.enabled = flag

func game_over() -> void:
	if not game_over_called:
		GameOver.emit()
		game_over_called = true
		camera.zoom = Vector2(4.0, 4.0)
