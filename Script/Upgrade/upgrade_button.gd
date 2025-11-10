class_name UpgradeButton
extends Button

@onready var name_label : Label = $VBox/Name
@onready var image : TextureRect = $VBox/Image
@onready var description: Label = $VBox/Description

var id
signal clicked

func set_button_UI(upgrade : Upgrade):
	id = upgrade.id
	name_label.text = upgrade.name
	image.texture = upgrade.image
	description.text = upgrade.description
	_set_type_text_color(upgrade.type)

func _set_type_text_color(type: Upgrade.Type):
	var settings: Resource
	match type:
		Upgrade.Type.WEAPON:
			settings = preload("res://UITheme/LabelSettings/weapon_label.tres")
		Upgrade.Type.CHARACTER_UPGRADE:
			settings = preload("res://UITheme/LabelSettings/upgrade_label.tres")
		Upgrade.Type.CONSUMABLE:
			settings = preload("res://UITheme/LabelSettings/consumable_label.tres")

	name_label.label_settings = settings

func _on_button_up() -> void:
	clicked.emit(id)
