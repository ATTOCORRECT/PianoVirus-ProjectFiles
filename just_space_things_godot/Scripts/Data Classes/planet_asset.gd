extends Resource
class_name PlanetAsset

@export var base : Texture2D
@export var base_color : Color
@export var surface_layer : Texture2D
@export var surface_layer_color : Color
@export var space_layer : Texture2D
@export var space_layer_color : Color
@export var surface_layer_rotation : float
@export var space_layer_rotation : float

func _init() -> void:
	var planet_assets : PlanetAssets = Singleton.planet_assets
	base = planet_assets.base
	surface_layer = planet_assets.surface_layers.pick_random()
	space_layer = planet_assets.space_layers.pick_random()
	
	base_color = Color.from_ok_hsl(randf(), randf_range(0.1, 0.9), randf_range(0.2, 0.8))
	surface_layer_color = Color.from_ok_hsl(randf(), randf_range(0.1, 0.9), randf_range(0.2, 0.8))
	space_layer_color = Color.from_ok_hsl(randf(), randf_range(0.1, 0.9), randf_range(0.2, 0.8))
	
	surface_layer_rotation = randf_range(0, 360)
	space_layer_rotation = randf_range(0, 360)

func _ready() -> void:
	pass 
