extends Control

@export var Messages: Array[Dm_data]
var event_index: int = 0

var message_loader: VBoxContainer
var dm_node = preload("res://Scenes/Panels/DirectMessages/new_message.tscn")
	
func _ready():
	message_loader = $ScrollContainer/VBoxContainer
	
	
func new_message():
	if (event_index < Messages.size()):
		var message = Messages[event_index]
		event_index += 1
	
		var dm_node_instance = dm_node.instantiate()
		dm_node_instance.construct(message)
		message_loader.add_child(dm_node_instance)
	else:
		pass


func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("Select"):
		new_message()
