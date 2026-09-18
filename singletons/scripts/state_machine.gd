extends Node
class_name StateMachineV2

@export var initial_state : State
@export var character : CharacterBody2D

var states: Dictionary = {}
var current_state : State

func _ready() -> void:
	#Adiciona os estados disponíveis no dicionário states
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transitioned)
	#Ativa o estado inicial
	if initial_state != null: #Isso é equivalente a -> if initial_state:
		initial_state.Enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state != null: #Isso é equivalente a -> if current_state:
		current_state.Update(delta)

func _physics_process(delta: float) -> void:
	if current_state != null: #Isso é equivalente a -> if current_state:
		current_state.Physics_Update(delta)

func on_child_transitioned(state, new_state_name):
	#Checa se o novo estado é diferente do atual
	if state != current_state:
		return
	#Checa se o novo estado é nulo
	var new_state : State = states.get(new_state_name.to_lower())
	if new_state == null: #Isso é equiivalente a -> if !new_state:
		return
	#Checa se o estado atual é nulo, e se for ativa a função de saída
	if current_state != null: #Isso é equivalente a -> if current_state:
		current_state.Exit()
	#Entra no novo estado
	new_state.Enter()
	current_state = new_state
