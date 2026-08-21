extends Node2D
class_name Obstacle

var distance: float =  1


func destroy():
	queue_free()


func _process(delta: float) -> void:
	position += Vector2.LEFT * GameMode.features.obstacle_base_speed * MainSingleton.stage.obstacle_speed_mult / distance * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
