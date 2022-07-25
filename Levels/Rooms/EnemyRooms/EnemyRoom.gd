extends RandomRoom
class_name EnemyRoom

export(PackedScene) var pot_small_scene : PackedScene

var rng := RandomNumberGenerator.new()

var pot_positions := [
	Vector3(69, 0.5, 69),
	Vector3(60, 0.5, 69),
	Vector3(69, 0.5, 60),
	Vector3(-69, 0.5, 69),
	Vector3(-60, 0.5, 69),
	Vector3(-69, 0.5, 60),
	Vector3(69, 0.5, -69),
	Vector3(60, 0.5, -69),
	Vector3(69, 0.5, -60),
	Vector3(-69, 0.5, -69),
	Vector3(-60, 0.5, -69),
	Vector3(-69, 0.5, -60)	
]

export (int) var MIN_POT_AMOUNT := 4
export (int) var MAX_POT_AMOUNT := 8

var enemies_positions := [
	Vector3(0, 2.5, 0),
	Vector3(30, 2.5, 0),
	Vector3(0, 2.5, 30),
	Vector3(-30, 2.5, 0),
	Vector3(0, 2.5, -30)
]

export (int) var MIN_ENEMY_AMOUNT := 2
export (int) var MAX_ENEMY_AMOUNT := 4

var enemies := []

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()

# Initializes the room with pots and enemies.
func _init_room():
	_generate_random_pots()
	_generate_random_enemies()

func _player_enter():
	lock_doors()

# Generates random pots around the room.
func _generate_random_pots() -> void:
	var pot_amount = rng.randi_range(MIN_POT_AMOUNT, MAX_POT_AMOUNT)
	
	var pot_real_positions = []
	var index = 0
	while index < pot_amount:
		var pot_position = pot_positions[rng.randi_range(0, pot_positions.size() - 1)]
		if not pot_position in pot_real_positions:
			pot_real_positions.append(pot_position)
			index += 1
		
	for position in pot_real_positions:
		var pot_instance : RigidBody = pot_small_scene.instance()
		add_child(pot_instance)
		pot_instance.global_transform.origin = self.global_transform.origin
		pot_instance.translate(position)
		
# Generates random enemies in the center of the room.
var enemies_amount : int
func _generate_random_enemies() -> void:
	enemies_amount = rng.randi_range(MIN_ENEMY_AMOUNT, MAX_ENEMY_AMOUNT)
	
	var enemies_real_positions = []
	var index = 0
	while index < enemies_amount:
		var enemy_position = enemies_positions[rng.randi_range(0, enemies_positions.size() - 1)]
		if not enemy_position in enemies_real_positions:
			enemies_real_positions.append(enemy_position)
			index += 1
			
	index = 0
	while index < enemies_amount:
		var enemy_scene : PackedScene = enemies[rng.randi_range(0, enemies.size() - 1)]
		var enemy : Spatial = enemy_scene.instance()
		add_child(enemy)
		enemy.connect("tree_exited", self, "enemy_die")
		enemy.global_transform.origin = self.global_transform.origin + enemies_real_positions[index].rotated(Vector3.UP, self.angle)
		index += 1

func enemy_die():
	enemies_amount -= 1
	if enemies_amount==0:
		unlock_doors()
