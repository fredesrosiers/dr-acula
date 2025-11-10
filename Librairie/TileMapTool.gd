extends Node
class_name TileMapTool

@export var spawn_tilemap: TileMapLayer
@export var blocked_tilemaps: Array[TileMapLayer]
@export var character: Character

func _is_blocked_tile(tile_pos: Vector2i) -> bool:
	for layer in blocked_tilemaps:
		if layer.get_cell_source_id(tile_pos) != -1:
			return true
	return false

func _is_spawnable_tile(tile_pos: Vector2i) -> bool:
	var tile_data := spawn_tilemap.get_cell_tile_data(tile_pos)
	if tile_data == null:
		return false
	if tile_data.get_custom_data("spawnable") != true:
		return false
	if _is_blocked_tile(tile_pos):
		return false
	return true

func get_random_spawn_position() -> Vector2:

	var used_rect := spawn_tilemap.get_used_rect()
	var max_tries := 100 

	for i in range(max_tries):
		var rand_tile := Vector2i(
			randi_range(used_rect.position.x, used_rect.end.x - 1),
			randi_range(used_rect.position.y, used_rect.end.y - 1)
		)
		
		# Vérifie si la tuile est valide
		if not _is_spawnable_tile(rand_tile):
			continue
		if _is_blocked_tile(rand_tile):
			continue

		var world_pos: Vector2 = spawn_tilemap.map_to_local(rand_tile)
		if character.get_camera_rect().has_point(world_pos):
			continue
		return world_pos
	
	push_warning("Aucune position de spawn valide trouvée après %d essais." % max_tries)
	return Vector2.ZERO  # fallback
