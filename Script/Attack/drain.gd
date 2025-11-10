extends WeaponNode

const START_SIZE:= Vector2(1.0, 1.0)
const FINAL_SIZE:= Vector2(4.5, 4.5)

func _process(delta: float):
	super._process(delta)
	var grow_factor : float = elapsed_time / animation_time
	collision.scale = lerp(START_SIZE, FINAL_SIZE, grow_factor)