extends RandomRoom

export(PackedScene) var pot_small_scene : PackedScene

var rng := RandomNumberGenerator.new()
var memo_puzzle := MemoPuzzle.new(4)

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

const MIN_POT_AMOUNT := 4
const MAX_POT_AMOUNT := 8

onready var spirit := $Spirit
onready var fox_statue := $Statues/FoxStatue
onready var fox_statue_2 := $Statues/FoxStatue2
onready var fox_statue_3 := $Statues/FoxStatue3
onready var fox_statue_4 := $Statues/FoxStatue4


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	fox_statue.set_memo_puzzle(memo_puzzle)
	fox_statue_2.set_memo_puzzle(memo_puzzle)
	fox_statue_3.set_memo_puzzle(memo_puzzle)
	fox_statue_4.set_memo_puzzle(memo_puzzle)
	
	memo_puzzle.connect("failed", self, "_reset_puzzle")
	memo_puzzle.connect("succeded", self, "_end_puzzle")

# Initializes the room with pots and enemies.
func _init_room():
	_generate_random_pots()

# Ends the puzzle.
func _end_puzzle():
	spirit.queue_free()
	print("you have won! :D")

# Resets the puzzle.
func _reset_puzzle():
	fox_statue.hide_interaction()
	fox_statue_2.hide_interaction()
	fox_statue_3.hide_interaction()
	fox_statue_4.hide_interaction()
	spirit.move_initial()
	spirit.appear()

# Interacts with the spirit.
func spirit_interact():
	_move_fox_statues()
	spirit.reset_movement()
	spirit.queue_move(fox_statue.get_nose_position())
	spirit.queue_move(fox_statue_2.get_nose_position())
	spirit.queue_move(fox_statue_3.get_nose_position())
	spirit.queue_move(fox_statue_4.get_nose_position())
	spirit.queue_move_initial()
	spirit.queue_dissapear()
	fox_statue.show_interaction()
	fox_statue_2.show_interaction()
	fox_statue_3.show_interaction()
	fox_statue_4.show_interaction()
	memo_puzzle.start()

# Moves the fox statues randomly.
func _move_fox_statues():
	var current_transforms = [
		fox_statue.global_transform,
		fox_statue_2.global_transform,
		fox_statue_3.global_transform,
		fox_statue_4.global_transform
	]
	current_transforms.shuffle()
	fox_statue.global_transform = current_transforms[0]
	fox_statue_2.global_transform = current_transforms[1]
	fox_statue_3.global_transform = current_transforms[2]
	fox_statue_4.global_transform = current_transforms[3]

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
		
		
