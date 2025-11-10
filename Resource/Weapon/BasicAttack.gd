class_name BasicAttack
extends Weapon

func _init():
	scene = preload("res://Scene/Attack/Basic.tscn")
	id = 0
	power = 1
	instances = 1
	type = Type.MELEE
	name = 'Basic Attack'
