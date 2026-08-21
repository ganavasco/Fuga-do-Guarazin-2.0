extends Area2D

@export var entry_scene: PackedScene
@export var item: Obstacle


func _on_area_entered(_area: Area2D) -> void:
	if not MainSingleton.unlocked_entries.has(entry_scene):
		MainSingleton.unlocked_entries.append(entry_scene)
	item.queue_free()
