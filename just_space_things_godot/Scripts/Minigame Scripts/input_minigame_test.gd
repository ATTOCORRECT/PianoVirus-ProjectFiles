extends Control

var correct_code: Array[int] = [0,0,0,0]
var user_code: Array [int] = [0,0,0,0]

var code_position: int = 0
var code_complete = false

@onready var code_label = $VBoxContainer/CodeLabel
@onready var userCode_label = $VBoxContainer/UserCodeLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	
	correct_code[0] = int(randf_range(1, 9))
	correct_code[1] = int(randf_range(1, 9))
	correct_code[2] = int(randf_range(1, 9))
	correct_code[3] = int(randf_range(1, 9))
	
	code_label.append_text(str(correct_code))
	userCode_label.append_text(str(user_code))
	
	print("Correct Code: " + str(correct_code))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _update_user_code():
	userCode_label.clear()
	userCode_label.append_text("[center][font_size={80}]" + str(user_code))


func _check_user_code():
	print ("Code Position: " + (str(code_position)))
	print ("User Code: " + str(user_code))
	
	if user_code == correct_code:
		userCode_label.clear()
		userCode_label.append_text("[center][font_size={80}][color=green]" + str(user_code))
		code_complete = true
	else:
		code_position += 1
		if code_position > 3 && !code_complete:
			code_position = 0
			user_code.fill(0)
	


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("1") && !code_complete:
		user_code[code_position] = 1
		_update_user_code()
		_check_user_code()
		
	
	if event.is_action_pressed("2") && !code_complete:
		user_code[code_position] = 2
		_update_user_code()
		_check_user_code()
		
	
	if event.is_action_pressed("3") && !code_complete:
		user_code[code_position] = 3
		_update_user_code()
		_check_user_code()
	
	
	if event.is_action_pressed("4") && !code_complete:
		user_code[code_position] = 4
		_update_user_code()
		_check_user_code()
		
	
	if event.is_action_pressed("5") && !code_complete:
		user_code[code_position] = 5
		_update_user_code()
		_check_user_code()
	
	if event.is_action_pressed("6") && !code_complete:
		user_code[code_position] = 6
		_update_user_code()
		_check_user_code()
	
	if event.is_action_pressed("7") && !code_complete:
		user_code[code_position] = 7
		_update_user_code()
		_check_user_code()
	
	if event.is_action_pressed("8") && !code_complete:
		user_code[code_position] = 8
		_update_user_code()
		_check_user_code()
	
	if event.is_action_pressed("9") && !code_complete:
		user_code[code_position] = 9
		_update_user_code()
		_check_user_code()
	
	if event.is_action_pressed("Select"):
		print("User Code: " + str(user_code))


func _Button_1_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("Select"):
		user_code[code_position] = 1
		_update_user_code()
		_check_user_code()


func _Button_2_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("Select"):
		user_code[code_position] = 2
		_update_user_code()
		_check_user_code()


func _Button_3_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("Select"):
		user_code[code_position] = 3
		_update_user_code()
		_check_user_code()


func _Button_4_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("Select"):
		user_code[code_position] = 4
		_update_user_code()
		_check_user_code()


func _Button_5_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("Select"):
		user_code[code_position] = 5
		_update_user_code()
		_check_user_code()


func _Button_6_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("Select"):
		user_code[code_position] = 6
		_update_user_code()
		_check_user_code()

func _Button_7_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("Select"):
		user_code[code_position] = 7
		_update_user_code()
		_check_user_code()

func _Button_8_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("Select"):
		user_code[code_position] = 8
		_update_user_code()
		_check_user_code()

func _Button_9_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("Select"):
		user_code[code_position] = 9
		_update_user_code()
		_check_user_code()
