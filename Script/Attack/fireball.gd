extends WeaponNode

@export var PROJECTILE_SPEED: float = 150.0
@export var timer: Timer

func _ready():
	super._ready()
	timer.timeout.connect(_stop)

func _process(delta: float):
	super._process(delta)
	var movement_delta = Vector2.RIGHT.rotated(rotation).normalized() * PROJECTILE_SPEED * delta
	position += movement_delta

func _stop() -> void:
	flip_h = false
	collision.disabled = true
	play('hit')
	PROJECTILE_SPEED = 0.0

func _on_hit(area: Area2D) -> void:
	if area.is_in_group('enemy'):
		call_deferred('_stop')
