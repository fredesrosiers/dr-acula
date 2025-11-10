extends Upgrade

func _init():
	id = 4
	type = Type.WEAPON
	name = 'Fire ball'
	image =  preload('res://Asset/Upgrade/fireball.png')
	description = 'Send a powerful fireball in a random direction'
	upgrade_class = FireBall