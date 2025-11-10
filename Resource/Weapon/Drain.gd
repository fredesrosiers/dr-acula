class_name Drain
extends Weapon

func _init():
	scene = preload("res://Scene/Attack/Drain.tscn")
	id = 2
	power = 1
	instances = 1
	type = Type.MELEE
	name = 'Life Drain'
	