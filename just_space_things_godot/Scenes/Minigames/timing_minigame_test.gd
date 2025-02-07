extends Control

var timer
var timer_value = 0.0
var timer_label
var success_label
var fail_label

@export var target_time = 4
@export var target_min = 3
@export var target_max = 8
@export var max_time = 9.9
var target_reached = false
var target_hit = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = $Timer
	timer_label = $TimerLabel
	success_label = $SuccessLabel
	fail_label = $FailLabel
	target_time = randi_range(target_min, target_max)
	
	
	print("target time:" + str(target_time))
	print ("Target Reached: " + str(target_reached))

func _process(delta: float) -> void:
	
	if target_hit :
		timer_label.label_settings.font_color = Color.LIME
		success_label.visible = true
	else :
		success_label.visible = false
	
	
	if timer_value >= target_time && timer_value <= target_time + 1 && !target_hit :
		timer_label.label_settings.font_color = Color.YELLOW
		target_reached = true
	
	if timer_value >= target_time + 1 :
		target_reached = false
		timer_label.label_settings.font_color = Color.WHITE
		print ("Target Reached: " + str(target_reached))
	
	if timer_value >= max_time || timer_value > target_time + 1 :
		fail_label.visible = true
		timer_label.label_settings.font_color = Color.RED
		timer.stop()
	else :
		fail_label.visible = false
		
	

func _input(event) :
		
	if Input.is_action_pressed("ui_accept") && target_reached :
		target_hit = true
		print ("Success!")
		timer.stop()
		

func _on_timer_timeout() -> void:
	timer_value += .1
	timer_label.text = "Timer: " + str(roundf(timer_value * 10) / 10) 


func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("Select") :
			target_hit = true
			print ("Success!")
			timer.stop()
