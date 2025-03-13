extends Node

@export var trends : Array[Trend]
@export var contacts: Array[Sender]

# Called when the node enters the scene tree for the first time.
func _enter_tree() -> void:
	Singleton.trends = trends
