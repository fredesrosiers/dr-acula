extends Upgrade

func _init():
	id = 2
	type = Type.WEAPON
	name = 'Pain Aura'
	image =  preload('res://Asset/Upgrade/drain.png')
	description = 'A damaging circle around you'
	upgrade_class = Drain