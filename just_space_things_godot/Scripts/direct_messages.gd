extends Control

@export var Messages: Array[Dm_data]
var event_index: int = 0

var message_loader: PanelContainer

var dm_node = preload("res://Scenes/Panels/DirectMessages/new_message.tscn")
	
func _ready():
	message_loader = $ScrollContainer/VBoxContainer/message_panel
	new_message()
	
func new_message():
	var message = Messages[event_index]
	event_index += 1
	
	var incoming_msg = New_Message.new(message)
	message_loader.add_child(incoming_msg)
	

	
