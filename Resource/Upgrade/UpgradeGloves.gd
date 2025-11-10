extends Upgrade

func _init():
	id = 6
	type = Type.CHARACTER_UPGRADE
	name = 'Artisan Gloves'
	image =  preload('res://Asset/Upgrade/gloves.png')
	description = 'Increase attack speed by 10%'
	callable = func(character: Character): character.set_attack_speed(character.attack_speed * 0.9)



