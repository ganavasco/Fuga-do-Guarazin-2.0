extends Node2D
class_name Fire

@export var fire_sprite: Node2D
@export var advanced_pos: Marker2D
@export var full_advanced_pos: Marker2D
@export var speed: float = 200

var target_pos: Vector2 = Vector2.ZERO


func _process(delta: float) -> void:
	fire_sprite.position.x = move_toward(fire_sprite.position.x, target_pos.x, delta*speed)
	fire_sprite.position.y = move_toward(fire_sprite.position.y, target_pos.y, delta*speed)


func go_to_zero() -> void:
	target_pos = Vector2.ZERO
	$Fire.stop()

func go_to_advanced() -> void:
	target_pos = advanced_pos.position
	$Fire.play()

func go_to_full_advanced() -> void:
	target_pos = full_advanced_pos.position


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.game_over()


func _on_water_detection() -> void:
	pass


func _on_water_detection_body_entered(body: Node2D) -> void:
	print("A")
	self.hide()
