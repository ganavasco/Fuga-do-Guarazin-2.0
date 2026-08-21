extends Area2D

@export var player: Player

var hurt: bool = false


func _on_area_entered(area: Area2D) -> void:
	if hurt:
		die()
	else:
		area.get_parent().destroy()
		get_hurt()

func get_hurt() -> void:
	hurt = true
	$HealTimer.start()
	MainSingleton.stage.fire.go_to_advanced()

func heal() -> void:
	hurt = false
	MainSingleton.stage.fire.go_to_zero()


func die() -> void:
	MainSingleton.stage.fire.go_to_full_advanced()
	await get_tree().create_timer(2).timeout
	MainSingleton.go_to_menu()
	


func _on_heal_timer_timeout() -> void:
	heal()
