class_name Poison
extends Weapon

func _init():
	scene = preload("res://Scene/Attack/Poison.tscn")
	id = 3
	power = 1
	instances = 2
	type = Type.RANGED
	name = 'Poison Bolts'
	
func attack(character : Character = null):
	for i in range(instances):
		var attack_sprite: WeaponNode = super.attack(character)
		if i == 0:
			attack_sprite.rotate(-PI/4)
		else :
			attack_sprite.rotate(PI/4)
