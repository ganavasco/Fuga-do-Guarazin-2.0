extends Node2D

@onready var player : PlayerTopView = $PlayerTopview
@onready var stage_cam : Camera2D = $Camera2D
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var fire_controler : Node2D = $FireControler
@onready var game_over_label : Control = $CanvasLayer/GameOver
@onready var player_spawn : Marker2D = $PlayerSpawn
@onready var fire_spawn : Marker2D = $FirePosition
@onready var estamina : TextureProgressBar = $CanvasLayer/VBoxContainer/Estamina
@onready var timer_estamina : Timer = $CanvasLayer/VBoxContainer/Timer

var update_pos : bool = false
var time : float = 0.0
var index : int = 0
var total_index : int
var fire_layers : Array

func _ready() -> void:
	new_game()

func _physics_process(delta: float) -> void:
	if update_pos:
		_update_position(delta)
	

func _update_position(delta) -> void:
	time += delta
	var intervalo : float = 0.5
	if time > intervalo:
		time -= intervalo
		#fire_layers[index].position.x += 280
		fire_controler.global_position.x += 20
		#print(fire_controler.position)
		#index -= 1
		#if index < 0:
		#	index = total_index - 1


func new_game() -> void:
	estamina.value = 100.0
	player.can_move = false
	player.game_over_called = false
	#player.fliph = false
	player.position = player_spawn.position
	fire_controler.position = fire_spawn.position
	game_over_label.hide()
	player.use_camera(false)
	stage_cam.enabled = true
	anim.play("FIRE_IGNITING", 0.0)
	await  anim.animation_finished
	timer_estamina.start()
	player.can_move = true
	update_pos = true
	#total_index = fire_controler.get_child_count()
	#index = total_index - 1
	#for child in fire_controler.get_children():
	#	fire_layers.append(child)
	stage_cam.enabled = false
	player.use_camera(true)

func game_over() -> void:
	print("game over")
	timer_estamina.stop()
	game_over_label.show()
	update_pos = false


func _on_timer_timeout() -> void:
	var tempo : float = 20
	var delta : float = 100/tempo
	estamina.value -= delta
	if estamina.value <= 0.0:
		player.game_over()

func _on_comida_comeu(estamina_value: float) -> void:
	estamina.value += estamina_value
