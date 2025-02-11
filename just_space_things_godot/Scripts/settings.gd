extends Node

@export var trends : Array[Trend]
@export var minigame : Node

# Called when the node enters the scene tree for the first time.
func _enter_tree() -> void:
	Singleton.trends = trends

func load_minigame():
	#$"../MinigamePanel/Interactive Screen/Viewport".add_child() << HERE
	pass
