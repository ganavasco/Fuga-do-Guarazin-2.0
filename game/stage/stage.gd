extends Node
class_name Stage

var progress: float = 0.0
var obstacle_speed_mult: float = 1.0
var weighted_progress: float = 0.0

@export var far: Sprite2D
@export var mid: Sprite2D
@export var close: Sprite2D
@export var ground: Sprite2D
@export var far_distance: float = 10
@export var mid_distance: float = 5
@export var close_distance: float = 2
@export var ground_distance: float = 1

@export var fire: Fire


func _ready() -> void:
	MainSingleton.stage = self


func _process(delta: float) -> void:
	progress += delta
	obstacle_speed_mult = 1 + progress * GameMode.features.speed_increase_ratio	# +log(pogress/2)/2 ?
	weighted_progress += delta * obstacle_speed_mult
	update_bg_scroll()


func update_bg_scroll() -> void:
	var scroll_progress: float = MainSingleton.stage.weighted_progress
	far.material.set("shader_parameter/progress", scroll_progress / far_distance)
	mid.material.set("shader_parameter/progress", scroll_progress / mid_distance)
	close.material.set("shader_parameter/progress", scroll_progress / close_distance)
	ground.material.set("shader_parameter/progress", scroll_progress / ground_distance)
