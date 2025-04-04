extends Node3D

@onready var messageScreen = $"Interactive Screen/Viewport/direct_messages"
var dm_screen = preload ("res://direct_messages.tscn")
@onready var timer = $messageTimer
var messageIndex = 0
@export var TimeBetweenMessages : Array[int]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_message_timer_timeout() -> void:
	messageScreen.new_message()
	if (messageIndex<TimeBetweenMessages.size()):
		timer.start(TimeBetweenMessages[messageIndex])
		messageIndex += 1
