extends Node3D

@onready var messageScreen = $"Interactive Screen/Viewport/direct_messages"
var dm_screen = preload ("res://direct_messages.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_area_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		messageScreen.new_message()
