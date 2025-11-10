class_name Destructible
extends AnimatedSprite2D

const DIFFERENT_TYPES : int = 5

signal destructed

var type : String

func _ready():
	var rng: int = randi_range(0, DIFFERENT_TYPES)
	type = String.num_int64(rng)
	animation = type
	animation_finished.connect(func():
		destructed.emit(self)
		queue_free()
		)


func _on_area_entered(area:Area2D) -> void:
	var attack = area.get_parent() as WeaponNode
	if attack:
		play(type)
		
