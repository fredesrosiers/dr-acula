extends Upgrade

func _init():
	id = 5
	type = Type.CHARACTER_UPGRADE
	name = 'Speed Boots'
	image =  preload('res://Asset/Upgrade/boots.png')
	description = 'Upgrade move speed by 10%'
	callable = func(character: Character): character.move_speed = character.move_speed * 1.1


