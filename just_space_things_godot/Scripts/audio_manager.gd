extends Node

@onready var global_speaker = $Global
@onready var generic_speaker = $GenericSpeaker
@onready var button_speaker = $Button
@onready var minigamesuccess_speaker = $MinigameSuccess
@onready var minigamefail_speaker = $MinigameFail
@onready var trend_select_speaker_one = $TrendSelectOne
@onready var trend_select_speaker_two = $TrendSelectTwo

func _enter_tree() -> void:
	Singleton.audio_manager = %AudioManager
	


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.

func play_button_takeoff_sound():
	button_speaker.play()

func play_minigame_success_sound():
	minigamesuccess_speaker.play()

func play_minigame_fail_sound():
	minigamefail_speaker.play()

func play_trend_select_one_sound():
	trend_select_speaker_one.play()
	pass 
	
func play_trend_select_two_sound():
	trend_select_speaker_two.play()
	pass 

func play_new_sfx(sfx):
	generic_speaker.stream = sfx
	generic_speaker.play()
