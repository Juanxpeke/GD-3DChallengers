extends Node

# Plays an audio stream
static func play(audio : AudioStream) -> void:
	var audio_player := AudioStreamPlayer.new()
	AudioStreamManager.add_child(audio_player)
	audio_player.stream = audio
	audio_player.connect("finished", audio_player, "queue_free")
	audio_player.play()

# Plays an audio stream in a certain 3D position
static func play_3d(audio : AudioStream, position : Vector3, audio_db : float = 0.0, audio_size : float = 1.0) -> void:
	var audio_player := AudioStreamPlayer3D.new()
	AudioStreamManager.add_child(audio_player)
	audio_player.stream = audio
	audio_player.global_transform.origin = position
	audio_player.unit_db = audio_db
	audio_player. unit_size = audio_size
	audio_player.connect("finished", audio_player, "queue_free")
	audio_player.play()

# Plays the default button hover audio.
static func play_button_hover() -> void:
	var button_hover_audio := load("res://Assets/Audio/GUI/abs-pointer.wav")
	play(button_hover_audio)
	
# Plays the default button clicked audio.
static func play_button_pressed() -> void:
	var button_pressed_audio := load("res://Assets/Audio/GUI/abs-confirm.wav")
	play(button_pressed_audio)
