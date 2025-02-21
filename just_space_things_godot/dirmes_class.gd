extends Node

@onready var sender_box = $ScrollContainer/VBoxContainer/message_panel/new_message/sender_panel/sender
@onready var message_box = $ScrollContainer/VBoxContainer/message_panel/new_message/message_body

@export var speaker: String
@export var message: String

func _init(i_speaker = "", i_message = ""):
	i_speaker = speaker
	i_message = message
	
	sender_box.text = i_speaker
	message_box.text = i_message
