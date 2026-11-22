class_name PathPainting
extends PathFollow2D

@export var river_data_layer: TileMapLayer
@export var water_source_id: int = 0
@export var water_atlas_coords: Vector2i = Vector2i(0, 0)
@export var brush_radius: int = 1 # 0 = 1x1 tile, 1 = 3x3 tiles
@export var painting: bool = false

func _process(_delta: float) -> void:
	if not painting or not river_data_layer:
		return
	#print(self.name)
	#print(progress_ratio)
	var local_pos = river_data_layer.to_local(global_position)
	var center_cell = river_data_layer.local_to_map(local_pos)
	
	for x in range(-brush_radius, brush_radius + 1):
		for y in range(-brush_radius, brush_radius + 1):
			var cell = center_cell + Vector2i(x, y)
			#print(cell)
			# Only paint if it's not already water
			if river_data_layer.get_cell_source_id(cell) != water_source_id:
				river_data_layer.set_cell(cell, water_source_id, water_atlas_coords)
