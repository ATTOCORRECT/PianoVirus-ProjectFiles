extends Node3D

@onready var messageScreen = $"Interactive Screen/Viewport/direct_messages"
var dm_screen = preload ("res://direct_messages.tscn")
@onready var timer = $dm_panel/Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_timer_timeout() -> void:
		messageScreen.new_message()
		#timer.start(-1)
	
