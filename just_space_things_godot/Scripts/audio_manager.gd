extends Node

@onready var global_speaker = $Global
@onready var button_speaker = $Button

func _enter_tree() -> void:
	Singleton.audio_manager = %AudioManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.

func play_button_takeoff_sound():
	button_speaker.play()
