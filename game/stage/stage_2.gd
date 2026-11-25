extends Node2D

signal win_signal

@export var turista_spawn: Marker2D
@export var turista: CharacterBody2D
@export var water_source_id: int = 1
@export var water_atlas_coords: Vector2i = Vector2i(2, 1)

@onready var player : PlayerTopView = $PlayerTopview
@onready var stage_cam : Camera2D = $Camera2D
@onready var stage_cam_final : Camera2D = $Camera2DFinal
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var fire_controler : Node2D = $FireControler
@onready var game_over_label : Control = $CanvasLayer/GameOver
@onready var player_spawn : Marker2D = $PlayerSpawn
@onready var fire_spawn : Marker2D = $FirePosition
@onready var estamina : TextureProgressBar = $CanvasLayer/HUD/VBoxContainer/Estamina
@onready var timer_estamina : Timer = $CanvasLayer/HUD/VBoxContainer/Timer
@onready var win: Control = $CanvasLayer/Win
@onready var river_data_layer: TileMapLayer = $Rio
@onready var areas : Node2D = $TuristaAreas/Areas

var update_pos : bool = false
var time : float = 0.0
var index : int = 0
var total_index : int
var fire_layers : Array
var intervalo : float = 0.4

func _ready() -> void:
	new_game()
	#anim.play("WaterFlood2")
	

func _physics_process(delta: float) -> void:
	if update_pos:
		_update_position(delta)
	
func _update_position(delta) -> void:
	time += delta
	if time > intervalo:
		time -= intervalo
		#fire_layers[index].position.x += 280
		fire_controler.global_position.x += 20
		if (player.global_position.x - fire_controler.global_position.x) > 1000.0:
			intervalo = 0.01
		elif (player.global_position.x - fire_controler.global_position.x) > 100.0:
			intervalo = 0.2
		else:
			intervalo = 0.4
		#print(fire_controler.position)
		#index -= 1
		#if index < 0:
		#	index = total_index - 1


func new_game() -> void:
	win.hide()
	estamina.value = 100.0
	player.can_move = false
	player.game_over_called = false
	player.fix_start_orientation()
	player.position = player_spawn.position
	turista.position = turista_spawn.position
	turista.disable_movement()
	reset_items()
	fire_controler.position = fire_spawn.position
	game_over_label.hide()
	player.use_camera(false)
	stage_cam.enabled = true
	anim.play("FIRE_IGNITING", 0.0)
	await  anim.animation_finished
	turista.enable_movement()
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

func reset_items() -> void:
	get_tree().call_group("Item", "reset_item")

func _on_win_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		#win.show()
		timer_estamina.stop()
		update_pos = false
		player.stop_player()
		player.use_camera(false)
		stage_cam_final.enabled = true
		anim.play("WaterFlood2")

func _on_continuar_pressed() -> void:
	print("Continuar apertado")
	MainSingleton.go_to_stage_3()

func paint_river_chunk(area: Rect2i) -> void:
	for x in range(area.position.x, area.end.x):
		for y in range(area.position.y, area.end.y):
			river_data_layer.set_cell(Vector2i(x, y), water_source_id, water_atlas_coords)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "WaterFlood2":
		win.show()

func update_tourist_target() -> void:
	var turista_x = turista.global_position.x
	for child in areas.get_children():
		if child.global_position.x > turista_x:
			turista.update_target(child)
			break
			
