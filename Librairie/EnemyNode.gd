extends AnimatedSprite2D
class_name EnemyNode

@export var collision_shape: CollisionShape2D

var id: int
var speed: float
var hp: int
var power: int
var is_suffering: bool = false
var is_alive: bool = true
var target_position : Vector2
var type: Enemy.Type

signal enemy_died

func _ready() -> void:
	animation_finished.connect(_handle_animation_end)

func spawn(pos: Vector2) -> void:
	global_position = pos
	play(_animation_name('walk'))	


func _physics_process(delta: float) -> void:
	if !is_alive:
		return
	
	var direction: Vector2 = (target_position - global_position).normalized()
	if type == Enemy.Type.FLYING:
		flip_h = direction.x > 0
	else:
		flip_h = direction.x < 0
	
	var move_vector := direction * speed * delta
	if !_is_colliding(move_vector):
		global_position += move_vector
	else:
		var try_x = Vector2(move_vector.x, 0)
		var try_y = Vector2(0, move_vector.y)
		
		if !_is_colliding(try_x):
			global_position += try_x
		elif !_is_colliding(try_y):
			global_position += try_y

func _is_colliding(move_vector: Vector2) -> bool:
	if type == Enemy.Type.FLYING:
		return false

	var space_state = get_world_2d().direct_space_state
	var params = PhysicsShapeQueryParameters2D.new()
	params.shape = collision_shape.shape
	params.transform = Transform2D(0, global_position + move_vector)
	params.collide_with_bodies = true
	params.collide_with_areas = false
	params.collision_mask = 1 << 2   #CHATGPT layer 3 → bit 2 (car layer1=bit0, layer2=bit1, etc.)
	
	var result = space_state.intersect_shape(params, 1)
	return result.size() > 0


func _handle_animation_end() -> void:
	if is_alive:
		play(_animation_name('walk'))
		

func _on_weapon_collision(area: Area2D) -> void:
	var weapon = area.get_parent() as WeaponNode
	if weapon:
		hp -= weapon.power
		if hp <= 0:
			die()
		elif !is_suffering:
			is_suffering = true
			play(_animation_name('hurt'))
			_flash()

func _animation_name(anim : String) -> String:
	return String.num_int64(id) + '_' + anim.capitalize()

func _flash():
	var original_color = modulate
	var original_speed = speed
	modulate = Color(1, 0.3, 0.3)  # rouge
	speed = 0.0
	await get_tree().create_timer(0.2).timeout
	modulate = original_color
	speed = original_speed
	is_suffering = false

func die():
	if is_alive:
		speed = 0.0
		is_alive = false
		play(_animation_name('dead'))
		var fade_out = create_tween()
		fade_out.tween_property(self, "modulate:a", 0.0, 2.0)
		await fade_out.finished
		enemy_died.emit(self)
		queue_free()
