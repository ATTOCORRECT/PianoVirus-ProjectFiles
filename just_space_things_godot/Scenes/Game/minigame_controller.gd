extends Node

@export var minigame : Array[Resource]

@onready var minigame_panel = $"../MinigamePanel"

var active_minigame : Node3D
var active_trend : Trend

func _enter_tree() -> void:
	Singleton.minigame_controller = %MinigameController
 
func load_minigame(trend: Trend):
	active_trend = trend
	var current_minigame = int(randf_range(0, minigame.size()))
	await get_tree().create_timer(2).timeout
	active_minigame = minigame[current_minigame].instantiate()
	minigame_panel.add_child(minigame[current_minigame].instantiate())
	print("Current Minigame Index: " + str(current_minigame))

func unload_minigame():
	if minigame_panel.get_child_count() == 0:
		return
	minigame_panel.remove_child(minigame_panel.get_child(0))
	active_minigame = null

#func _on_button_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	#if active_minigame != null and event is InputEventMouseButton:
		#minigame_panel.get_child(0).on_button_event(event)

func minigame_completed(score : float):
	Singleton.audio_manager.play_minigame_success_sound()
	await get_tree().create_timer(2).timeout
	Singleton.map.spend_current_star()
	unload_minigame()
	Singleton.engagement.add_velocity(score, active_trend.value)


func minigame_failed():
	Singleton.audio_manager.play_minigame_fail_sound()
	await get_tree().create_timer(2).timeout
	Singleton.map.spend_current_star()
	unload_minigame()
