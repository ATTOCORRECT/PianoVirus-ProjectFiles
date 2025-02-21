extends Node3D

@export var zoom_fov = 20
var active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("zoom_in"):
		$Area3D.process_mode = Node.PROCESS_MODE_INHERIT
		await get_tree().process_frame
		$Area3D.process_mode = Node.PROCESS_MODE_DISABLED


#func _on_area_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	#if event is InputEventMouseButton:
		#if event.is_action_pressed("zoom_in") or event.is_action_pressed("zoom_toggle"):
			#await get_tree().process_frame
			#await get_tree().process_frame
			#Singleton.player.override_zoom(global_position.normalized(), zoom_fov)
			#pass
	#pass # Replace with function body.


func _on_area_3d_mouse_entered() -> void:
	Singleton.player.override_zoom(global_position.normalized(), zoom_fov)
	$Area3D.process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.
