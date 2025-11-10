class_name Bat
extends Enemy

func _init():
	id = 4
	type = Type.FLYING
	name = 'Bat'
	hp = 5
	speed = 45.0
	power = 1
	scene = preload('res://Scene/Enemy/FlyingEnemy.tscn')

