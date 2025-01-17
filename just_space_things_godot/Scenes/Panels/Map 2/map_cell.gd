extends Node3D
class_name Map_cell

var cell_position : Vector3
var cell_position_offset : Vector3
var map_node

var in_range = false

func _init(in_cell_position, in_map_node) -> void:
	cell_position = in_cell_position
	map_node = in_map_node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = cell_position
	var map_node_instance = map_node.instantiate()
	map_node_instance.position = Vector3(randf() * 0.8,randf() * 0.8,randf() * 0.8)
	add_child(map_node_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = cell_position + cell_position_offset
	
	var color
	
	if (abs(position.x + 0.5) < 2 && abs(position.y + 0.5) < 2 && abs(position.z + 0.5) < 2):
		in_range = true
		color = Color.ROYAL_BLUE
	else:
		in_range = false
		color = Color.DIM_GRAY
	
	var parent_position = get_parent_node_3d().position
	#DebugDraw3D.draw_box(cell_position + cell_position_offset + parent_position, Quaternion.IDENTITY, Vector3.ONE, color)

func set_position_offset(in_position_offset : Vector3):
	cell_position_offset = in_position_offset
