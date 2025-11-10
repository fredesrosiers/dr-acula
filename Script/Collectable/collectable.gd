extends AnimatedSprite2D
class_name Collectable

signal collected

@export var animation_player: AnimationPlayer

func _ready():
	animation_player.play("grow")

func _on_character_collision(area: Area2D) -> void:
	if area.is_in_group('character'):
		collected.emit(self)
		queue_free()
		