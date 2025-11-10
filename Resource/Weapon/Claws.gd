class_name Claws
extends Weapon

func _init():
	scene = preload("res://Scene/Attack/Claws.tscn")
	id = 1
	power = 1
	instances = 1
	type = Type.MELEE
	name = 'Blood Claws'

func attack(character: Character = null):
	var attack_sprite: WeaponNode = super.attack(character)
	attack_sprite.rotate(PI)

	