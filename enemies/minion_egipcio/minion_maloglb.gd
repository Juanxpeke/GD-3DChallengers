extends IEnemy

onready var animator = $AnimationPlayer
onready var face = $meshish/head

# Called when the node enters the scene tree for the first time.
func _ready():
	animator.connect("animation_finished", self, "a")
	set_state(initial_state.new())
	
func a(name):
	state.alerted = false

func look_up_face():
	var dir : Vector3 = vec_to_player_face(self.face)
	var angle;
	if dir.y > 0:
		angle = Vector3(dir.x, 0, dir.z).angle_to(dir)
	else:
		angle = -Vector3(dir.x, 0, dir.z).angle_to(dir)
	#print(angle)
	face.rotation.x = angle
	

class initial_state extends State:
	
	const follow_distance = 80
	
	func _process(delta):
		var dif = enemy_node.global_transform.origin - PlayerManager.get_player_position()
		if dif.length() < follow_distance and not alerted:
			enemy_node.animator.play("fire_sequence")
			alerted = true
		if alerted:
			enemy_node.face_player()
			enemy_node.look_up_face()
