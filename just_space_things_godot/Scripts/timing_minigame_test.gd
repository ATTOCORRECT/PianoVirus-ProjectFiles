extends Control

@onready var game_timer = $Minigame/GameTimer
@onready var instruction_timer = $InstructionTimer
@onready var ready_timer = $ReadyTimer
@onready var countdown_timer = $CountdownTimer

@onready var timer_label = $Minigame/TimerLabel
@onready var success_label = $Minigame/SuccessLabel
@onready var success_rich_label = $Minigame/SuccessRichLabel
@onready var fail_label = $Minigame/FailLabel
@onready var instruction_label = $VBoxContainer_Instruction/InstructionLabel
@onready var ready_label = $VBoxContainer_Ready/ReadyLabel
@onready var countdown_label = $VBoxContainer_Countdown/CountdownLabel
@onready var idle_container = $VBoxContainer_Idle

var game_timer_value = 0.0
var score = 1.0
@export var target_time = 4
@export var target_min = 3
@export var target_max = 8
@export var max_time = 9.9
var target_reached = false
var target_hit = false

var game_start = false
var game_over = false
var show_instructions = false
var show_ready = false
var show_countdown = false

var countdown_value = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer_label.label_settings.font_color = Color.WHITE
	target_time = randi_range(target_min, target_max)
	
	print("target time:" + str(target_time))
	print ("Target Reached: " + str(target_reached))

func _process(delta: float) -> void:
	
	if target_hit :
		timer_label.label_settings.font_color = Color.LIME
		success_rich_label.visible = true
	else :
		success_rich_label.visible = false
	
	
	if game_timer_value >= target_time && game_timer_value <= target_time + 1 && !target_hit :
		timer_label.label_settings.font_color = Color.YELLOW
		target_reached = true
	
	
	if game_timer_value >= target_time + 1 :
		target_reached = false
		timer_label.label_settings.font_color = Color.WHITE
		print ("Target Reached: " + str(target_reached))
	
	if game_timer_value >= max_time || game_timer_value > target_time + 1 :
		game_over = true
		fail_label.visible = true
		timer_label.label_settings.font_color = Color.RED
		game_timer.stop()
		Singleton.minigame_controller.minigame_failed()
		process_mode = ProcessMode.PROCESS_MODE_DISABLED
		
	else :
		fail_label.visible = false
		

func _on_timer_timeout() -> void:
	game_timer_value += .1
	timer_label.text = "Timer: " + str(roundf(game_timer_value * 10) / 10) 
	print("Score: " + str(score))
	
	if target_reached :
		score -= .1


func _on_instruction_timer_timeout() -> void:
	instruction_label.visible = false
	ready_label.visible = true
	ready_timer.start()

func _on_ready_timer_timeout() -> void:
	ready_label.visible = false
	countdown_label.visible = true
	countdown_timer.start()

func _on_countdown_timer_timeout() -> void:
	countdown_value += 1
	
	if countdown_value == 1 :
		countdown_label.clear()
		countdown_label.push_font_size(120)
		countdown_label.append_text("[center] 2")
		countdown_label.pop()
	
	if countdown_value == 2 :
		countdown_label.clear()
		countdown_label.push_font_size(160)
		countdown_label.append_text("[center] 1")
		countdown_label.pop()
	
	if countdown_value == 3 :
		countdown_label.clear()
		countdown_label.push_font_size(200)
		countdown_label.append_text("[wave amp=125.0 freq=25.0 connected=1][rainbow freq=0.7 sat=0.8 val=0.8][center]GO!")
	
	if countdown_value >= 4 :
		countdown_label.visible = false
		timer_label.visible = true
		game_timer.start()
		countdown_timer.stop()
		countdown_value = 0

#func _input(event) :
	#if event.is_action_pressed("Select") && !game_start :
		#idle_container.visible = false
		#game_start = true
		#instruction_label.visible = true
		#instruction_timer.start()
	#
	#if Input.is_action_pressed("Select") && target_reached && game_start:
		#target_hit = true
		#print ("Success!")
		#game_timer.stop()

func on_button_event(event: InputEvent):
	print("recieved input")
	if event.is_action_pressed("Select") && !game_start :
		idle_container.visible = false
		game_start = true
		instruction_label.visible = true
		instruction_timer.start()
	
	if event.is_action_pressed("Select") && target_reached && game_start :
		target_hit = true
		Singleton.minigame_controller.minigame_completed(score) # replace number with reward score
		game_timer.stop()
		game_over = true

#func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	#if event is InputEventMouseButton:
		#if event.is_action_pressed("Select") && !game_start :
			#idle_container.visible = false
			#game_start = true
			#instruction_label.visible = true
			#instruction_timer.start()
			#
		#
		#if event.is_action_pressed("Select") && target_reached && game_start :
			#target_hit = true
			#print ("Success!")
			#game_timer.stop()
			#game_over = true
		
		#if event.is_action_pressed("Select") && game_over :
			#ready_label.visible = true
			#ready_timer.start()
			#game_over = false
			#
			#game_timer_value = 0
			#timer_label.visible = false
			#success_label.visible = false
			#fail_label.visible = false
