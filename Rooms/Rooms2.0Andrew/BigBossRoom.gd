extends RandomRoom

onready var area = $Area
onready var env = $WorldEnvironment
export (PackedScene) var bossScene = preload("res://enemies/attack_patterns/Remiel.tscn")
export (Vector3) var boss_initial_pos = Vector3(0, 7, 60)
# Called when the node enters the scene tree for the first time.
func _ready():
	area.connect("body_entered", self, "start_fight")

func start_fight(body):
	if body == PlayerManager.get_player():
		var boss = bossScene.instance()
		add_child(boss)
		boss.set_initial_pos(boss_initial_pos)
		boss.set_room_size(self.size)
		boss.phase2_position = Vector3(0, 30, -40)
		boss.ground_height = 0.5
		area.queue_free()
		env.environment = load("res://Rooms/Rooms2.0Andrew/BigBossRoom_env.tres")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
