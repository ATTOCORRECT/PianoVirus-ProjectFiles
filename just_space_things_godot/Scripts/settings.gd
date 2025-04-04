extends Node

@export var trends : Array[Trend]
@export var contacts : Array[Sender]
@export var planet_assets : PlanetAssets

# Called when the node enters the scene tree for the first time.
func _enter_tree() -> void:
	Singleton.trends = trends
	Singleton.planet_assets = planet_assets
