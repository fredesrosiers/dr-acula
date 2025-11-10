class_name Weapon
extends Resource

enum Type {
	MELEE,
	RANGED,
}

var scene : PackedScene
var id: int
var power: int
var instances: int
var type: Type
var name: String 

func attack(character : Character = null) -> WeaponNode:
	var attack_sprite : WeaponNode = scene.instantiate()
	attack_sprite.rotation = character.get_orientation()
	attack_sprite.power = power
	if type == Type.MELEE:
		character.add_child(attack_sprite)
	elif type == Type.RANGED:
		character.get_parent().add_child(attack_sprite)
		attack_sprite.position = character.global_position
	return attack_sprite