extends Upgrade

func _init():
	id = 7
	type = Type.CHARACTER_UPGRADE
	name = 'Human Heart'
	image =  preload('res://Asset/Upgrade/heart.png')
	description = 'Increase max hp by 1'
	callable = func(character: Character): character.increase_max_hp(1)
