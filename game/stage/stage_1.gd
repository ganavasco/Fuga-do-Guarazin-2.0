extends Node2D

@export var turista: CharacterBody2D

func _ready() -> void:
	turista.enable_movement()
