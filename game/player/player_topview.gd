extends CharacterBody2D


@export var SPEED : float = 100.0
@export var anim_player : AnimationPlayer
@export var sprite : Sprite2D

var direction : Vector2 = Vector2.ZERO
var last_direction : String = "RIGHT"

func _ready() -> void:
	anim_player.play("IDLE")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
	#	velocity.x = direction * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)
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
