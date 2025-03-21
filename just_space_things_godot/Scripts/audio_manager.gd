extends Node

@onready var global_speaker = $Global
@onready var generic_speaker = $GenericSpeaker
@onready var button_speaker = $Button
@onready var minigamesuccess_speaker = $MinigameSuccess
@onready var minigamefail_speaker = $MinigameFail
#@onready var trend_select_speaker = $TrendSelect

func _enter_tree() -> void:
	Singleton.audio_manager = %AudioManager
	
	#if music is not playing then restart it

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.

func play_button_takeoff_sound():
	button_speaker.play()

func play_minigame_success_sound():
	minigamesuccess_speaker.play()

func play_minigame_fail_sound():
	minigamefail_speaker.play()

func play_trend_select_sound():
	pass 
	#trend_select_speaker.play()

func play_new_sfx(sfx):
	generic_speaker.stream = sfx
	generic_speaker.play()
