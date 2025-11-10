extends PanelContainer
class_name UpgradeUI

@export var upgrade_panel: PanelContainer
@export var upgrade_buttons: Array[UpgradeButton]  = []
@export var progress_bar: ProgressBar
@export var initial_currency: int = 5
@export var currency_increment: int = 5

@onready var animation: AnimationPlayer = $AnimationPlayer

var is_closing: bool = false

func _ready() -> void:
	upgrade_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	progress_bar.max_value = initial_currency
	animation.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(_anim_name: String) -> void:
	if is_closing:
		get_tree().paused = false
		upgrade_panel.visible = false
	else:
		mouse_filter = Control.MOUSE_FILTER_STOP


func resume() -> void:
	is_closing = true
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	reset_bar(int(progress_bar.max_value) + currency_increment)
	animation.play_backwards('blur')

func paused() -> void:
	upgrade_panel.visible = true
	is_closing = false
	get_tree().paused = true
	animation.play('blur')

func set_upgrades(upgrades: Array[Upgrade]) -> void:
		for i in range(len(upgrade_buttons)):
			upgrade_buttons[i].set_button_UI(upgrades[i])

func reset_bar(new_max: int) -> void:
	progress_bar.set_value_no_signal(0)
	progress_bar.max_value = new_max