
extends EnemyRoom

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	enemies = [
		preload("res://enemies/bat/bat.tscn"),
		preload("res://enemies/minion_egipcio/minion_maloglb.tscn"),
	]
	pot_positions = [
	Vector3(69, 0.5, 69),
	Vector3(54, 0.5, 69),
	Vector3(69, 0.5, 54),
	Vector3(-69, 0.5, 69),
	Vector3(-54, 0.5, 69),
	Vector3(-69, 0.5, 54),
	Vector3(69, 0.5, -69),
	Vector3(54, 0.5, -69),
	Vector3(69, 0.5, -54),
	Vector3(-69, 0.5, -69),
	Vector3(-60, 0.5, -69),
	Vector3(-69, 0.5, -54)	
	]
	
	enemies_positions = [
	Vector3(0, 2.5, 0),
	Vector3(30, 2.5, 0),
	Vector3(0, 2.5, 30),
	Vector3(-30, 2.5, 0),
	Vector3(0, 2.5, -30)
	]


# Initializes the room with pots and enemies.
func _init_room():
	_generate_random_pots()
	_generate_random_enemies()
