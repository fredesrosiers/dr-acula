class_name Enemy
extends Resource

enum Type {
	GROUND,
	FLYING,
}

var id: int
var type: Type
var name: String
var hp: int
var speed: float
var power: int
var scene: PackedScene = preload('res://Scene/Enemy/Enemy.tscn')

func spawn() -> EnemyNode:
	var enemy: EnemyNode = scene.instantiate()
	enemy.id = id
	enemy.hp = hp
	enemy.speed = speed
	enemy.power = power
	enemy.type = type
	return enemy
	


