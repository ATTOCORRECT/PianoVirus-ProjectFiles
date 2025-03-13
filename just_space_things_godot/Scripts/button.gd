extends Node3D

@export var mesh : MeshInstance3D
@onready var material = mesh.get_surface_override_material(0)
@export var color : Color

func _ready() -> void:
	material.albedo_color = color

func disable_button():
	material.albedo_color = Color(color.r * 0.5, color.g * 0.5, color.b * 0.5)
	process_mode = ProcessMode.PROCESS_MODE_DISABLED

func set_color(in_color: Color):
	color = in_color
	if process_mode == ProcessMode.PROCESS_MODE_DISABLED:
		material.albedo_color = Color(color.r * 0.5, color.g * 0.5, color.b * 0.5)
	else:
		material.albedo_color = color

func enable_button():
	material.albedo_color = color
	process_mode = ProcessMode.PROCESS_MODE_INHERIT
	pass
