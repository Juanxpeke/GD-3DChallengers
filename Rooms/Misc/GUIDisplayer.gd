extends MeshInstance

export(StreamTexture) var interaction_icon : StreamTexture
export(String) var interaction_message : String
export(PackedScene) var gui_scene : PackedScene

var previous_mouse_mode

onready var collision_shape := $StaticBody/CollisionShape
onready var interaction := $Interaction
onready var gui_control := $CanvasLayer/GUIControl

# Called when the node enters the scene tree for the first time.
func _ready():
	# Setting the collision shape.
	collision_shape.shape = mesh.create_trimesh_shape()
	
	# Configuring the GUI control.
	gui_control.add_child(gui_scene.instance())
	gui_control.hide()
	
	# Connections.
	gui_control.connect("hide", self, "_resume_game")
	
	# Setting the interaction variables.
	if interaction_icon != null:
		interaction.interaction_icon = interaction_icon
	if interaction_message != null:
		interaction.interaction_message = interaction_message

# Called on each input event.
func _input(event):
	if event.is_action_pressed("ui_cancel") and gui_control.visible:
		get_tree().set_input_as_handled()

# Interacts with the node.
func interact() -> void:
	_show_gui_control()

# Shows the GUI contorl and pauses the game.
func _show_gui_control() -> void:
	gui_control.show()
	previous_mouse_mode = Input.get_mouse_mode()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	
# Resumes the game
func _resume_game() -> void:
	Input.set_mouse_mode(previous_mouse_mode) 
	get_tree().paused = false

