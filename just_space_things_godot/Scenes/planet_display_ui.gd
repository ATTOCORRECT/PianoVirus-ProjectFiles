extends PanelContainer

@export var planet_base_texture : TextureRect
@export var planet_surface_texture : TextureRect
@export var planet_space_texture : TextureRect

func update_planet_textures(planet_asset : PlanetAsset):
	
	planet_base_texture.texture  = planet_asset.base
	planet_base_texture.modulate = planet_asset.base_color
	
	planet_surface_texture.texture  = planet_asset.surface_layer
	planet_surface_texture.modulate = planet_asset.surface_layer_color
	planet_surface_texture.pivot_offset = planet_surface_texture.size / 2
	planet_surface_texture.rotation_degrees = planet_asset.surface_layer_rotation
	
	planet_space_texture.texture  = planet_asset.space_layer
	planet_space_texture.modulate = planet_asset.space_layer_color
	planet_space_texture.pivot_offset = planet_space_texture.size / 2
	planet_space_texture.rotation_degrees = planet_asset.space_layer_rotation
