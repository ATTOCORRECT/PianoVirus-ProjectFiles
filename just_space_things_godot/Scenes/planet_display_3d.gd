extends Node3D

@export var planet_base_texture : Sprite3D
@export var planet_surface_texture : Sprite3D
@export var planet_space_texture : Sprite3D

func _enter_tree() -> void:
	Singleton.planet_display = self

func clear_planet_textures():
	planet_base_texture.texture = null

	planet_surface_texture.texture = null

	planet_space_texture.texture = null


func update_planet_textures(planet_asset : PlanetAsset):
	planet_base_texture.texture  = planet_asset.base
	planet_base_texture.modulate = planet_asset.base_color
	
	planet_surface_texture.texture  = planet_asset.surface_layer
	planet_surface_texture.modulate = planet_asset.surface_layer_color
	planet_surface_texture.rotation_degrees = Vector3(0,0, -planet_asset.surface_layer_rotation)
	
	planet_space_texture.texture  = planet_asset.space_layer
	planet_space_texture.modulate = planet_asset.space_layer_color
	planet_space_texture.rotation_degrees = Vector3(0,0, -planet_asset.space_layer_rotation)
	
	position = Vector3(randf_range(-7,7), randf_range(-3,3), 0)
	scale = randf_range(1,6) * Vector3.ONE
