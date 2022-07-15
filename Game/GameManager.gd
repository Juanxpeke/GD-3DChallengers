extends Node

const DISPLAY_MODES := [
	true,
	false
]

const RESOLUTIONS := [
	Vector2(1920, 1080),
	Vector2(1600, 900),
	Vector2(1280, 720),
	Vector2(1024, 600)
]

const GUI_SIZES = [
	Vector2(0.8, 0.8),
	Vector2(1.0, 1.0),
	Vector2(1.2, 1.2)
]
const GAME_DATA_PATH := "user://save_file.save"

var game_data := {
	"settings" : {
		"display_mode" : 1,
		"resolution" : 3,
		"gui_size" : 1
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	load_data()
	update_graphics_settings()

# Called on a certain notification.
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		save_data()
		get_tree().quit()
		
# Saves the game data.
func save_data() -> void:
	var saveFile := File.new()
	saveFile.open(GAME_DATA_PATH, File.WRITE)
	saveFile.store_line(to_json(game_data))
	saveFile.close()
	
# Loads the game data.
func load_data() -> void:
	var openFile := File.new()
	
	if not openFile.file_exists(GAME_DATA_PATH):
		return
	
	openFile.open(GAME_DATA_PATH, File.READ)
	
	# while not necessary 
	while openFile.get_position() < openFile.get_len():
		game_data = parse_json(openFile.get_line())

	openFile.close()
	

# Updates the window display mode.
func update_display_mode() -> void:
	OS.window_fullscreen = DISPLAY_MODES[game_data["settings"]["display_mode"]]

# Updates the window resolution.
func update_resolution() -> void:
	OS.window_size = RESOLUTIONS[game_data["settings"]["resolution"]]
	OS.window_position = (OS.get_screen_size() - OS.window_size) * 0.5

# Updates the GUI size.
func update_gui_size() -> void:
	for node in get_tree().get_nodes_in_group("resizable_gui"):
		node.rect_scale = GUI_SIZES[game_data["settings"]["gui_size"]]

# Updates every graphic setting.
func update_graphics_settings() -> void:
	update_display_mode()
	update_resolution()
	update_gui_size()
