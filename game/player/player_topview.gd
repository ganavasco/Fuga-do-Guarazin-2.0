extends CharacterBody2D


@export var SPEED : float = 100.0
@export var anim_player : AnimationPlayer
@export var sprite : Sprite2D

var direction : Vector2 = Vector2.ZERO
var last_direction : String = "RIGHT"

func _ready() -> void:
	anim_player.play("IDLE")

func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta
	update_animation()
	move_and_slide()

func update_animation():
	if direction != Vector2.ZERO:
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
