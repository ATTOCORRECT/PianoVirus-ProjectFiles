extends Control

var timer
var timer_value = 0.0
var timer_label

@export var target_time = 4
@export var target_min = 3
@export var target_max = 9
@export var max_time = 9.9


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = $Timer
	timer_label = $TimerLabel
	target_time = randi_range(target_min, target_max)
	
	print("target time:" + str(target_time))

func _process(delta: float) -> void:
	if timer_value >= target_time :
		timer_label.label_settings.font_color = Color.LIME
	
	if timer_value >= max_time :
		timer.stop()
		

func _on_timer_timeout() -> void:
	timer_value += .1
	timer_label.text = "Timer: " + str(timer_value) 
