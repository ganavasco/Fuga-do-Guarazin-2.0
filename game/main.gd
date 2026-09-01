extends Node
class_name Main

@onready var stage_scene = preload("res://game/stage/stage.tscn")
@onready var main_menu_scene = preload("res://game/menus/main_menu.tscn")
@onready var intro_scene = preload("res://game/cutscenes/intro.tscn")

var main: Node
var stage: Stage

@export var unlocked_entries: Array[PackedScene] = []
@export var button_sound:AudioStreamMP3


func _ready() -> void:
	MainSingleton.main = self


func change_scene(new_scene: PackedScene) -> void:
	MainSingleton.main.get_child(0).queue_free()
	var new_scene_instance = new_scene.instantiate()
	MainSingleton.main.add_child(new_scene_instance)
	return
	# Add button sounds
	var buttons: Array = get_tree().get_nodes_in_group("Button")
	for inst in buttons:
		inst.connect("pressed", self, "on_button_pressed")

func on_button_pressed()->void:
	button_sound.play()


func go_to_stage() -> void:
	change_scene(stage_scene)

func go_to_menu() -> void:
	change_scene(main_menu_scene)

func go_to_intro() -> void:
	change_scene(intro_scene)
