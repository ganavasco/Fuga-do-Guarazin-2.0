extends Resource
class_name GameFeatures

@export_group("Player Constants")
@export var player_jump_force := 900.0
@export var player_fastfall_force := 900.0

@export_group("Obstacles Constants")
@export var obstacle_base_speed := 500.0
@export var obstacle_min_wait := 1.5
@export var obstacle_max_wait := 3.0

@export_group("Stage Constants")
@export var progress_to_score_ratio := 100.0
@export var score_zeroes_padding := 10
@export var speed_increase_ratio: float = 1.0/25.0
