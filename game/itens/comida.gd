extends Area2D

signal comeu(estamina_value : float)

@export var replenish_value : float = 50.0
@export var sprite : Sprite2D
@export var popup_scene : PackedScene

func _ready() -> void:
	if not popup_scene:
		popup_scene = load("res://game/itens/popup.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		comeu.emit(replenish_value)
		sprite.hide()
		var popup = popup_scene.instantiate()
		add_child(popup) 
		set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)

func reset_item() -> void:
	sprite.show()
	set_deferred("process_mode", Node.PROCESS_MODE_INHERIT)
