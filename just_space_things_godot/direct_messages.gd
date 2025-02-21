extends Control

@export var sender: String
@export var message: String

@onready var sender_box: RichTextLabel = $ScrollContainer/VBoxContainer/message_panel/new_message/sender_panel/sender
@onready var message_box: RichTextLabel = $ScrollContainer/VBoxContainer/message_panel/new_message/message_body

	
func _ready():
	sender_box.set_text(sender)
	message_box.set_text(message)

	
