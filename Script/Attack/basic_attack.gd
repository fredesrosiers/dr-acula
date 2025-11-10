extends WeaponNode


func _process(delta: float):
	super._process(delta)
	if elapsed_time > animation_time / 3:
		collision.disabled = true