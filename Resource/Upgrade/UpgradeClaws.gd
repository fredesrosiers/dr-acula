extends Upgrade

func _init():
	id = 1
	type = Type.WEAPON
	name = 'Blood Claws'
	image =  preload('res://Asset/Upgrade/claws.png')
	description = 'Send a large backward attack'
	upgrade_class = Claws

