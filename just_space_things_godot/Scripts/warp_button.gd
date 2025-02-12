extends Node3D



func disable_warp_button():
	visible = false
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
	pass

func enable_warp_button():
	visible = true
	process_mode = ProcessMode.PROCESS_MODE_INHERIT
	pass
