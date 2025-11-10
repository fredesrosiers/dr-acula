extends Upgrade

func _init():
	id = 0
	type = Type.CONSUMABLE
	name = 'Blood Cocktail'
	image =  preload('res://Asset/Upgrade/potion.png')
	description = 'Heal for 3 hearts'
	callable = func(character: Character): character.heal(3)
