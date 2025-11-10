extends Node2D
class_name EnemySpawner

@export var character: Character
@export var spawn_timer: Timer
@export var spawn_time: float = 1
@export var enemy_per_wave: int = 50
@export var map_tool: TileMapTool

signal enemy_died


var current_wave = 1
var active_enemies: Array[EnemyNode] = []
var enemy_pool: Array[EnemyNode] = []
var enemy_types: Array[Enemy] = [Trader.new()]

func _ready():
	create_enemy_pool(enemy_per_wave)
	spawn_timer.wait_time = spawn_time

func _process(_delta: float):
	for e: EnemyNode in active_enemies:
		e.target_position = character.global_position

func create_enemy_pool(enemy_count: int) -> void:
	enemy_pool.clear()
	for i in enemy_count:
		var enemy: EnemyNode = enemy_types.pick_random().spawn()
		enemy_pool.append(enemy)

func _on_spawn_timer() -> void:
	if len(enemy_pool) >= 1:
		if len(active_enemies) < 1000:
			var enemy: EnemyNode = enemy_pool.pop_back()
			active_enemies.append(enemy)
			enemy.enemy_died.connect(_handle_enemy_death)
			add_child(enemy)
			enemy.spawn(map_tool.get_random_spawn_position())
	else:
		next_wave()

func next_wave() -> void:
	current_wave += 1
	spawn_timer.wait_time = spawn_timer.wait_time * 0.9
	increase_enemy_difficulty()
	create_enemy_pool(enemy_per_wave)

func increase_enemy_difficulty() -> void:
	if current_wave % 5 == 0:
		for enemy in enemy_types:
			enemy.hp += 2
			enemy.speed += 5
	if current_wave == 2:
		enemy_types.append(Gatherer.new())
	elif current_wave == 3:
		enemy_types.append(Mosquito.new())
	elif current_wave == 4:
		enemy_types.append(Bat.new())
	
func _handle_enemy_death(enemy: EnemyNode):
	if enemy in active_enemies:
		active_enemies.erase(enemy)
		enemy_died.emit(enemy.global_position + Vector2(0,10), 0.5)
