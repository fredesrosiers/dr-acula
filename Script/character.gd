class_name Character
extends CharacterBody2D

@export var map_tool: TileMapTool
@export var move_speed : float = 1200.0
@export var attack_speed : float = 2.0
@export var cooldown_bar: ProgressBar
@export var sprite: AnimatedSprite2D
@export var attack_timer: Timer
@export var sprite_area: Area2D
@export var camera: Camera2D
@export var life_bar: LifeBar
@export var hp: int = 5
var max_hp: int

const ANIM_DIRECTION = {
	Vector2.RIGHT: "R",
	Vector2.LEFT: "L",
	Vector2.UP: "U",
	Vector2.DOWN: "D"
}

signal dead

var is_alive = true
var active_weapons : Array[Weapon] = [BasicAttack.new()] #basic attack
var orientation := Vector2(0,1)
var is_doing_action: bool = false
var is_vulnerable: bool = true

func get_orientation() -> float:
	if orientation.y != 0:
		return Vector2(0, orientation.y).angle()
	else:
		return Vector2(orientation.x, 0).angle()

func _ready():
	sprite.play('Idle_D')
	sprite.animation_finished.connect(_handle_animation_end)
	_set_attack_cooldown()
	life_bar.prepare(hp)
	max_hp = hp
	global_position = map_tool.get_random_spawn_position()


	
func _unhandled_key_input(event: InputEvent) -> void:
	if !is_doing_action and event.is_released():
		_start_animation('Idle')

func _physics_process(_delta: float) -> void:
	if not is_alive:
		return
	cooldown_bar.value = (attack_timer.wait_time - attack_timer.time_left) * 100
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * move_speed
	move_and_slide()
	if !is_doing_action and direction != Vector2.ZERO:
		if direction.y < 0:
			orientation = Vector2.UP
		elif direction.y > 0:
			orientation = Vector2.DOWN
		elif direction.x < 0:
			orientation = Vector2.LEFT
		elif direction.x > 0:
			orientation = Vector2.RIGHT
		_start_animation('Walk')
	_check_enemy_collision()

func _start_animation(anim_name: String) -> void:
	var animation: String = "%s_%s" % [anim_name.capitalize(), ANIM_DIRECTION[orientation]]
	if sprite.animation != animation:
		sprite.play(animation)

func _handle_animation_end() -> void:
	_start_animation('Idle')
	is_doing_action = false
	is_vulnerable = true

func _on_attack() -> void:
	if not is_alive:
		return
	is_doing_action = true
	for weapon in active_weapons:
		weapon.attack(self)
	_start_animation('Attack')

func set_attack_speed(speed: float) -> void:
	attack_speed = speed
	_set_attack_cooldown()

func _set_attack_cooldown() -> void:
	attack_timer.wait_time = attack_speed
	cooldown_bar.max_value = attack_timer.wait_time * 100

func heal(heal_amount: int) -> void:
	hp += heal_amount
	hp = clamp(hp, 0, max_hp)
	life_bar.set_hp(hp)

func increase_max_hp(increase: int = 1) -> void:
	if max_hp + increase <= 10:
		life_bar.add_token(false)
		max_hp += increase

func add_weapon(weapon: Weapon) -> void:
	active_weapons.append(weapon)

func has_weapon(id: int) -> bool:
	return (active_weapons.any(func(w): return w.id == id))

func get_weapon(id: int) -> Weapon:
	for w: Weapon in active_weapons:
		if w.id == id:
			return w
	return null

func get_camera_rect() -> Rect2:
	var size: Vector2 = camera.get_viewport_rect().size
	return Rect2(camera.global_position - size * 0.5, size)

func _suffer_damage(dmg: int) -> void:
	if is_vulnerable:
		is_vulnerable = false
		is_doing_action = true
		heal(-dmg)
		if hp > 0:
			_start_animation('Hurt')
		else:
			_die()

func _on_enemy_collide(area: Area2D) -> void:
	if area.is_in_group('enemy'):
		var enemy: EnemyNode = area.get_parent()
		if enemy and enemy.is_alive:
			_suffer_damage(enemy.power)
			
func _check_enemy_collision() -> void:
	for area: Area2D in sprite_area.get_overlapping_areas():
		_on_enemy_collide(area)

func _die() -> void:

	is_alive = false
	if sprite.animation_finished.is_connected(_handle_animation_end):
		sprite.animation_finished.disconnect(_handle_animation_end)

	sprite.animation_finished.connect(_on_death_finished)
	_start_animation('die')

func _on_death_finished() -> void:
	if sprite.animation.begins_with("Die"):
		dead.emit()