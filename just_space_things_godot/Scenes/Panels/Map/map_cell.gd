extends Node3D
class_name Map_cell

var cell_position : Vector3
var cell_position_offset : Vector3
var map_node

var in_range = false

var key : String

func _init(in_cell_position, in_map_node, in_key) -> void:
	cell_position = in_cell_position
	map_node = in_map_node
	key = in_key

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = cell_position
	var map_node_instance = map_node.instantiate()
	
	#seed(key.hash())
	map_node_instance.position = Vector3(randf() * 0.7,randf() * 0.7,randf() * 0.7)
	add_child(map_node_instance)
	var child : Node3D = get_child(0)
	child.key = key
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = cell_position + cell_position_offset

func set_position_offset(in_position_offset : Vector3):
	cell_position_offset = in_position_offset
