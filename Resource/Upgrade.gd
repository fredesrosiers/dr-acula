class_name Upgrade
extends Resource

enum Type {
	CHARACTER_UPGRADE,
	WEAPON,
	CONSUMABLE,
}

var id: int
var type: Type
var name: String
var image: Texture2D
var description: String
var upgrade_class: GDScript
var callable: Callable

func upgrade_character(character : Character):
	match type:
		Type.WEAPON:
			_upgrade_character_weapon(character)
		Type.CONSUMABLE, Type.CHARACTER_UPGRADE:
			callable.call(character)

func _upgrade_character_weapon(character: Character) -> void:
	var weapon = character.get_weapon(id) 
	if weapon == null:
		character.add_weapon(upgrade_class.new())
	else:
		weapon.power += 1