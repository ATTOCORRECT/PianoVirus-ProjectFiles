extends Control
class_name New_Message

#strings to hold text content for sender and message
var sender: String
var message: String

var message_data: Dm_data
#variables hold path to the Rich Text Labels
var sender_rtl: RichTextLabel
var message_rtl: RichTextLabel
var sender_pfp: Sprite2D

func _init() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func construct(new_message_data) -> void:
	message_data = new_message_data
	sender = message_data.sender.name
	message = message_data.message
	
	sender_rtl = $message_panel/message/sender_panel/sender
	message_rtl = $message_panel/message/message_body
	sender_pfp = $message_panel/message/sender_panel/PanelContainer/Sprite2D
	
	sender_rtl.set_text(sender)
	sender_pfp.texture = message_data.sender.pfp
	message_rtl.set_text(message)
