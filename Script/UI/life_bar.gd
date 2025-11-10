extends Control
class_name LifeBar

@export var heart_token_scene : PackedScene

var tokens: Array[HeartToken] = []
const ICON_PADDING: float = 20.0
	
func prepare(start_life: int) -> void:
	for i in range(start_life):
		add_token(true)

func set_hp(hp: int) -> void:
	for i in range(tokens.size()):
		if i < hp:
			tokens[i].full()
		else:
			tokens[i].empty()
		
func add_token(full: bool) -> void:
	var token = heart_token_scene.instantiate() as HeartToken
	token.position.x = len(tokens) * ICON_PADDING
	if full:
		token.full()
	else:
		token.empty()
	add_child(token)
	tokens.append(token)