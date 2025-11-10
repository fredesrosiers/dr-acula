class_name FireBall
extends Weapon

func _init():
	scene = preload("res://Scene/Attack/Fireball.tscn")
	id = 4
	power = 5
	instances = 1
	type = Type.RANGED
	name = 'Fire Ball'
	
func attack(character : Character = null):
	var attack_sprite : WeaponNode = super.attack(character)
	attack_sprite.rotate(randf_range(0.0, 2.0) * PI)
