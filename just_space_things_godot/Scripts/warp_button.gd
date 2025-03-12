extends Node3D



func disable_warp_button():
	#visible = false
	$CSGCylinder3D.material.albedo_color = Color.DARK_RED
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
	pass

func enable_warp_button():
	#visible = true
	$CSGCylinder3D.material.albedo_color = Color.RED
	process_mode = ProcessMode.PROCESS_MODE_INHERIT
	pass
