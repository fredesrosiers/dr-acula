extends Node
class_name UpgradeMachine

@export var character : Character
@export var upgrade_ui : UpgradeUI
@export var CHOICE_NB: int = 3

const UPGRADE_PATHS = [
		"res://Resource/Upgrade/UpgradeBoots.gd",
		"res://Resource/Upgrade/UpgradeClaws.gd",
		"res://Resource/Upgrade/UpgradeDrain.gd",
		"res://Resource/Upgrade/UpgradeFireball.gd",
		"res://Resource/Upgrade/UpgradeGloves.gd",
		"res://Resource/Upgrade/UpgradeHP.gd",
		"res://Resource/Upgrade/UpgradeMaxHp.gd",
		"res://Resource/Upgrade/UpgradePoison.gd",
	]

var currency: int = 0

var all_upgrades: Array[Upgrade]
var current_upgrades: Array[Upgrade]

func _ready():
	all_upgrades = _load_all_upgrades()
	_add_button_listeners()
	set_new_current_upgrades()

func add_currency(nb: int = 1) -> void:
	var progress_bar: ProgressBar = upgrade_ui.progress_bar
	currency += nb
	progress_bar.value = currency
	if currency >= progress_bar.max_value:
		currency = 0
		upgrade_ui.paused()

	

func _add_button_listeners() -> void:
	for btn: UpgradeButton in upgrade_ui.upgrade_buttons:
		btn.clicked.connect(apply_upgrade)
	

func _load_all_upgrades() -> Array[Upgrade]:
	var upgrades: Array[Upgrade] = []

	for path in UPGRADE_PATHS:
		var script = load(path)
		if script:
			var upgrade: Upgrade = script.new()
			upgrades.append(upgrade)
		else:
			push_warning("⚠️ Impossible de charger : " + path)

	return upgrades


func _get_random_upgrades(nb_upgrade: int = 3) -> Array[Upgrade]:
	var random_upgrades: Array[Upgrade] = []
	if len(all_upgrades) >= nb_upgrade:
		all_upgrades.shuffle()
		random_upgrades = all_upgrades.slice(0,3)
	return random_upgrades

func set_new_current_upgrades() -> void:
	current_upgrades = _get_random_upgrades(CHOICE_NB)
	upgrade_ui.set_upgrades(current_upgrades)

func apply_upgrade(id: int) -> void:
	for up in current_upgrades:
		if up.id == id:
			up.upgrade_character(character)
			upgrade_ui.resume()
			await get_tree().create_timer(0.5).timeout
			set_new_current_upgrades()
			return


