class_name Game
extends Node


@export var CHARACTER: Character
@export var ENEMY_SPAWNER: EnemySpawner
@export var LOOT_SPAWNER: LootSpawner
@export var UPGRADE_MACHINE: UpgradeMachine
@export var GAME_OVER_UI: GameOverUI


var kill_count: int = 0

func _ready():
	# DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	ENEMY_SPAWNER.enemy_died.connect(_on_enemy_death)
	CHARACTER.dead.connect(_on_characted_death)
	LOOT_SPAWNER.add_currency.connect(UPGRADE_MACHINE.add_currency)

func _on_enemy_death(pos: Vector2, loot_chance: float) -> void:
	LOOT_SPAWNER.spawn_collectable(pos, loot_chance)
	kill_count += 1

func _on_characted_death() -> void:
	GAME_OVER_UI.appear(kill_count, ENEMY_SPAWNER.current_wave)