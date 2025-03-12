extends Node3D

@export var color : Color

func disable_button():
	$CSGCylinder3D.material.albedo_color = Color(color.r * 0.5, color.g * 0.5, color.b * 0.5)
	process_mode = ProcessMode.PROCESS_MODE_DISABLED

func set_color(in_color: Color):
	color = in_color
	if process_mode == ProcessMode.PROCESS_MODE_DISABLED:
		$CSGCylinder3D.material.albedo_color = Color(color.r * 0.5, color.g * 0.5, color.b * 0.5)
	else:
		$CSGCylinder3D.material.albedo_color = color

func enable_button():
	$CSGCylinder3D.material.albedo_color = color
	process_mode = ProcessMode.PROCESS_MODE_INHERIT
	pass
