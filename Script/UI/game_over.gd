class_name GameOverUI
extends Control

@export var kill_label: Label
@export var wave_label: Label
@export var continue_btn: Button
@export var quit_btn: Button
@export var animation_player: AnimationPlayer

func _ready():
	randomize()
	continue_btn.pressed.connect(_on_restart_pressed)
	quit_btn.pressed.connect(_on_quit_pressed)
	visible = false
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func appear(kill_count: int, wave_count: int) -> void:
	kill_label.text += String.num_int64(kill_count)
	wave_label.text += String.num_int64(wave_count-1)
	visible = true
	mouse_filter = Control.MOUSE_FILTER_STOP
	get_tree().paused = true
	animation_player.play('appear')

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().quit()