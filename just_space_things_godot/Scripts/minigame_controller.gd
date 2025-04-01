extends Node

@export var minigame : Array[Resource]

@onready var minigame_marker = $"../MinigameMarker"

@export var minigame_panel_animator : AnimationPlayer

var active_minigame : Node3D
var active_trend : Trend

func _enter_tree() -> void:
	Singleton.minigame_controller = %MinigameController

func _ready() -> void:
	minigame_panel_animator.current_animation = "animate_minigame_panel"

func load_minigame(trend: Trend):
	active_trend = trend
	var current_minigame = int(randf_range(0, minigame.size()))
	
	#await get_tree().create_timer(0.2).timeout
	minigame_panel_animator.play_backwards("animate_minigame_panel")
	print("load")
	active_minigame = minigame[current_minigame].instantiate()
	minigame_marker.add_child(minigame[current_minigame].instantiate())
	#print("Current Minigame Index: " + str(current_minigame))
	Singleton.audio_manager.switch_music(true)
	
	

func unload_minigame():
	if minigame_marker.get_child_count() == 0:
		return
	minigame_panel_animator.play("animate_minigame_panel")
	await get_tree().create_timer(1).timeout
	minigame_marker.remove_child(minigame_marker.get_child(0))
	Singleton.audio_manager.switch_music(false)
	active_minigame = null

func minigame_completed(score : float):
	Singleton.audio_manager.play_minigame_success_sound()
	print("Sound played: minigame success")
	await get_tree().create_timer(1).timeout
	Singleton.map.spend_current_star()
	unload_minigame()
	Singleton.engagement.add_velocity(score, active_trend.value)

func minigame_failed():
	Singleton.audio_manager.play_minigame_fail_sound()
	print("Sound played: minigame fail")
	await get_tree().create_timer(1).timeout
	Singleton.map.spend_current_star()
	unload_minigame()
