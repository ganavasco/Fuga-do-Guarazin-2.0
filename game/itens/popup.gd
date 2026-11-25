extends Node2D

@export var x_value : float = 0.0
@export var y_value : float = 20.0
@export var tween_duration : float = 0.5
@export var label : Label

func _ready() -> void:
	if not label:
		label = get_child(0)
	var tween : Tween = create_tween()
	var final_position = self.position + Vector2(x_value, -y_value)
	tween.tween_property(self, "position", final_position, tween_duration)
	tween.tween_property(label, "modulate:a", 0.0, tween_duration)
	tween.tween_callback(self.queue_free)
