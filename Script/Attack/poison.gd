extends WeaponNode

const START_POSITION: float = 30.0
const FINAL_POSITON: float = 200.0
@export var PROJECTILE_SPEED: float = 100.0

func _ready():
	super._ready()
	animation_time = animation_time - 0.2

func _process(delta: float):
	super._process(delta)
	var movement_delta = Vector2.RIGHT.rotated(rotation).normalized() * PROJECTILE_SPEED * delta
	var grow_factor : float = elapsed_time / animation_time
	collision.position.x = lerp(START_POSITION, FINAL_POSITON, grow_factor)
	position += movement_delta
