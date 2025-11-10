extends Upgrade

func _init():
	id = 3
	type = Type.WEAPON
	name = 'Poison Bolts'
	image =  preload('res://Asset/Upgrade/poison.png')
	description = '2 Poisoning Projectiles'
	upgrade_class = Poison