extends Control

@export var start_btn: Button
@export var animation_player: AnimationPlayer

func _ready() -> void:
	get_tree().paused = true
	start_btn.pressed.connect(_start_animation)
	animation_player.animation_finished.connect(_start_game)

func _start_animation() -> void:
	animation_player.play('start')

func _start_game(_anim_name: String) -> void:
	get_tree().paused = false
	queue_free()