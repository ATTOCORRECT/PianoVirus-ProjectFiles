extends Control

var timer
var timer_value = 0.0
var timer_label

var target_time = 5
var max_time = 9.9


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = $Timer
	timer_label = $TimerLabel
	pass # Replace with function body.

func _process(delta: float) -> void:
	if timer_value == target_time :
		#timer_label.font_color = Color(LIME)
	
	if timer_value >= max_time :
		timer.stop()
		

func _on_timer_timeout() -> void:
	timer_value += .1
	timer_label.text = "Timer: " + str(timer_value) 
