extends Node3D

@onready var star = $Star
var map
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	map = get_parent_node_3d().get_parent_node_3d()
	star.visible = false
	star.PROCESS_MODE_DISABLED
	var material : StandardMaterial3D = $Star/CSGSphere3D.get_material()
	material.albedo_color = Color(randf(), randf(), randf())
	$Star/CSGSphere3D.set_material(material)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var local_position = global_position - map.global_position
	
	if (abs(local_position.x) < 3/2.0 && abs(local_position.y) < 1/2.0 && abs(local_position.z) < 2/2.0):
		star.visible = true
		star.PROCESS_MODE_INHERIT
	else:
		star.visible = false
		star.PROCESS_MODE_DISABLED
	pass


func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_action_released("Select"):
			map.set_map_position_target(global_position - map.global_position)
	pass # Replace with function body.
