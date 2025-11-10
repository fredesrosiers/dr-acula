extends Node
class_name LootSpawner

@export var collectable_scene: PackedScene
@export var destructible_scene: PackedScene
@export var nb_destructible: int = 100
@export var map_tool: TileMapTool

signal add_currency

func _ready():
	for i in range(nb_destructible):
		var destructible: Destructible = destructible_scene.instantiate()
		destructible.global_position = map_tool.get_random_spawn_position()
		destructible.destructed.connect(func(dest: Destructible): spawn_collectable(dest.global_position))
		add_child(destructible)
		

func spawn_collectable(loot_position: Vector2, drop_chance: float = 1) -> void:
	if drop_chance > randf():
		var loot: Collectable = collectable_scene.instantiate()
		add_child(loot)
		loot.global_position = loot_position
		loot.collected.connect(_on_loot_collected)

func _on_loot_collected(_loot: Collectable) -> void:
	add_currency.emit(1)
