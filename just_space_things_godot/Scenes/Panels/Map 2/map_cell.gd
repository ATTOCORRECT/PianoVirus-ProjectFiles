extends Node3D
class_name Map_cell

var cell_position : Vector3
var cell_position_offset : Vector3

func _init(in_cell_position) -> void:
	cell_position = in_cell_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("hi")
	position = cell_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	DebugDraw3D.draw_box(cell_position + cell_position_offset, Quaternion.IDENTITY, Vector3.ONE, Color.WHITE)

func set_position_offset(in_position_offset : Vector3):
	cell_position_offset = in_position_offset
