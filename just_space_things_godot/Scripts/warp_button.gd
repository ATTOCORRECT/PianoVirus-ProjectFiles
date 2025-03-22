extends Node3D

@export var mesh : MeshInstance3D
@onready var material = mesh.get_surface_override_material(0)
@export var color : Color

func _ready() -> void:
	material.albedo_color = color

func disable_warp_button():
	#visible = false
	Singleton.audio_manager.play_button_takeoff_sound()
	#print("the big thing")
	material.albedo_color = Color(color.r * 0.5, color.g * 0.5, color.b * 0.5)
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
	pass

func enable_warp_button():
	#visible = true
	
	material.albedo_color = color
	process_mode = ProcessMode.PROCESS_MODE_INHERIT
	pass
