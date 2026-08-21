extends Node2D
class_name ObstacleSpawner

@export var obstacles_pool: Array[PackedScene]
@export var spawn_timer: Timer
@export var distance: float = 1
@export var obstacle_min_wait: float = 1.5
@export var obstacle_max_wait: float = 3


func spawn_obstacle() -> void:
	var obstacle: Obstacle = obstacles_pool.pick_random().instantiate()
	
	# Adjust distance
	obstacle.distance = distance
	obstacle.scale /= distance
	
	# For obstacles
	if distance < 1.5:
		add_child(obstacle)
		return
	# Else for background objects
	
	# Random tweaks
	var rand_scale = randf_range(-0.07, 0.07)
	obstacle.scale += Vector2(rand_scale, rand_scale)
	if randf() > 0.5:
		obstacle.scale.x *= -1
	
	add_child(obstacle)


func _on_spawn_timer_timeout() -> void:
	spawn_obstacle()
	spawn_timer.wait_time = randf_range(obstacle_min_wait, obstacle_max_wait)
