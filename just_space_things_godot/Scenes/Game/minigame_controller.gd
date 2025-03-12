extends Node

@export var minigame : Resource

@onready var minigame_panel_viewport = $"../MinigamePanel/Interactive Screen/Viewport"

var active_minigame : Control
var active_trend : Trend

func _enter_tree() -> void:
	Singleton.minigame_controller = %MinigameController

func load_minigame(trend: Trend):
	active_trend = trend
	await get_tree().create_timer(2).timeout
	active_minigame = minigame.instantiate()
	minigame_panel_viewport.add_child(minigame.instantiate())

func unload_minigame():
	minigame_panel_viewport.remove_child(minigame_panel_viewport.get_child(0))
	active_minigame = null

func _on_button_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if active_minigame != null and event is InputEventMouseButton:
		minigame_panel_viewport.get_child(0).on_button_event(event)

func minigame_completed(score : float):
	await get_tree().create_timer(2).timeout
	Singleton.map.spend_current_star()
	unload_minigame()
	Singleton.engagement.add_velocity(score, active_trend.value)


func minigame_failed():
	await get_tree().create_timer(2).timeout
	Singleton.map.spend_current_star()
	unload_minigame()
