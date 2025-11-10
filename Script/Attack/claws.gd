extends WeaponNode

@export var timer: Timer

const START_POSITION: float = 35.0
const FINAL_POSITON: float = 135.0

func _on_timer_timeout() -> void:
	collision.disabled = true

func _process(delta: float):
	super._process(delta)
	if timer.time_left > 0:
		var grow_factor : float = elapsed_time / timer.wait_time
		collision.position.x = lerp(START_POSITION, FINAL_POSITON, grow_factor)
		
