extends RandomRoom

export(PackedScene) var pot_small_scene : PackedScene
export(PackedScene) var bat_enemy_scene : PackedScene
export(PackedScene) var minion_enemy_scene : PackedScene
export(PackedScene) var sand_soldier_scene : PackedScene
export(PackedScene) var Itempedestal_scene : PackedScene
export(PackedScene) var SmallChest_scene : PackedScene
export(PackedScene) var RubyRing_scene : PackedScene
export(PackedScene) var LeatherBackpack_scene : PackedScene
export(PackedScene) var IronHelmet_scene : PackedScene
export(PackedScene) var IronGloves_scene : PackedScene
export(PackedScene) var IronChestplate_scene : PackedScene
export(PackedScene) var GoldenChest_scene : PackedScene
export(PackedScene) var AlphaCore_scene : PackedScene
var rng := RandomNumberGenerator.new()
var item_instance : Item
var pot_positions := [
	Vector3(129.5, 0.5, 129.5),
	Vector3(124.5, 0.5, 129.5),
	Vector3(129.5, 0.5, 124.5),
	
	Vector3(-129.5, 0.5, 129.5),
	Vector3(-124.5, 0.5, 129.5),
	Vector3(-129.5, 0.5, 124.5),
	
	Vector3(129.5, 0.5, -129.5),
	Vector3(124.5, 0.5, -129.5),
	Vector3(129.5, 0.5, -124.5),
	
	Vector3(-129.5, 0.5, -129.5),
	Vector3(-124.5, 0.5, -129.5),
	Vector3(-129.5, 0.5, -124.5),
	
	Vector3(99.5, 0.5, 129.5),
	Vector3(94.5, 0.5, 129.5),
	Vector3(99.5, 0.5, 124.5),
	
	Vector3(-129.5, 0.5, 99.5),
	Vector3(-124.5, 0.5, 99.5),
	Vector3(-129.5, 0.5, 94.5),
	
	Vector3(129.5, 0.5, -99.5),
	Vector3(124.5, 0.5, -99.5),
	Vector3(129.5, 0.5, -94.5),
	
	Vector3(-99.5, 0.5, -129.5),
	Vector3(-94.5, 0.5, -129.5),
	Vector3(-99.5, 0.5, -124.5),
	
	Vector3(129.5, 0.5, 99.5),
	Vector3(124.5, 0.5, 99.5),
	Vector3(129.5, 0.5, 94.5),
	
	Vector3(-99.5, 0.5, 129.5),
	Vector3(-94.5, 0.5, 129.5),
	Vector3(-99.5, 0.5, 124.5),
	
	Vector3(99.5, 0.5, -129.5),
	Vector3(94.5, 0.5, -129.5),
	Vector3(99.5, 0.5, -124.5),
	
	Vector3(-129.5, 0.5, -99.5),
	Vector3(-124.5, 0.5, -99.5),
	Vector3(-129.5, 0.5, -94.5),]

const MIN_POT_AMOUNT := 12
const MAX_POT_AMOUNT := 24

var enemies_positions := [
	Vector3(30, 2.5, 0),
	Vector3(0, 2.5, 30),
	Vector3(-30, 2.5, 0),
	Vector3(0, 2.5, -30),
	Vector3(60, 2.5, 60),
	Vector3(-60, 2.5, 60),
	Vector3(-60, 2.5, -60),
	Vector3(60, 2.5, -60),
	Vector3(90, 2.5, 30),
	Vector3(-90, 2.5, 30),
	Vector3(-90, 2.5, -30),
	Vector3(90, 2.5, -30)
]

const MIN_ENEMY_AMOUNT := 8
const MAX_ENEMY_AMOUNT := 12

var enemies := []
var items := []
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	enemies = [bat_enemy_scene, minion_enemy_scene, sand_soldier_scene]
	items = [SmallChest_scene.instance(), RubyRing_scene.instance(), LeatherBackpack_scene.instance(), IronHelmet_scene.instance(), IronGloves_scene.instance(), IronChestplate_scene.instance(), GoldenChest_scene.instance(), AlphaCore_scene.instance()]
	_generate_random_pots()
	_generate_random_enemies()
	_generate_random_item()
# Initializes the room with pots and enemies.
func _init_room():
	pass
#Genera un item al azar en medio de la Sala 
func _generate_random_item() -> void:
	var item_instance = items[rng.randi_range(0, 8)]
	var item_real_positions = []
	var item_scene : PackedScene = Itempedestal_scene
	var item : Spatial = item_scene.instance()
	item.global_transform.origin = Vector3(0,0,0)
	add_child(item)
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
		pot_instance.global_transform.origin = position
		add_child(pot_instance)
		
# Generates random enemies in the center of the room.
func _generate_random_enemies() -> void:
	var enemies_amount = rng.randi_range(MIN_ENEMY_AMOUNT, MAX_ENEMY_AMOUNT)
	
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
		enemy.global_transform.origin = enemies_real_positions[index]
		add_child(enemy)
		index += 1
