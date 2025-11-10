class_name WeaponNode
extends AnimatedSprite2D

@export var collision : CollisionShape2D

var animation_time : float = get_animation_time()
var elapsed_time : float = 0.0
var power: int

func _ready() -> void:
	play('animation')
	animation_finished.connect(queue_free)


func get_animation_time() -> float:
	return sprite_frames.get_frame_count('animation')  / sprite_frames.get_animation_speed('animation')

func _process(delta : float):
	elapsed_time += delta