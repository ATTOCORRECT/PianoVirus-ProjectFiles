extends Control

@export var Messages: Array[Dm_data]
var event_index: int = 0

var message_loader: VBoxContainer
var dm_node = preload("res://Scenes/Panels/DirectMessages/new_message.tscn")
	
func _ready():
	message_loader = $ScrollContainer/VBoxContainer
	new_message()
	new_message()
	
func new_message():
	var message = Messages[event_index]
	event_index += 1
	
	var dm_node_instance = dm_node.instantiate()
	dm_node_instance.construct(message)
	message_loader.add_child(dm_node_instance)

	
