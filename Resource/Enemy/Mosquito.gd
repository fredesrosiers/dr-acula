class_name Mosquito
extends Enemy

func _init():
	id = 3
	type = Type.FLYING
	name = 'Mosquito'
	hp = 1
	speed = 65.0
	power = 1
	scene = preload('res://Scene/Enemy/FlyingEnemy.tscn')

