extends Control

var answer_code : Array[int]
var guess_code : Array[int]
var code_length = 10

@export var answer_text : RichTextLabel
@export var input_text : RichTextLabel

var font = load("res://Assets/Fonts/terminal-grotesque.ttf")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_code()
	update_answer_text()
	update_input_text()

func generate_code():
	for i in code_length:
		var random_int = randi_range(1,9)
		answer_code.append(random_int)

func update_answer_text():
	answer_text.clear()
	answer_text.push_font(font)
	answer_text.push_font_size(64)
	
	answer_text.append_text("Verify")
	answer_text.newline()
	answer_text.append_text(array_as_string(answer_code))
	
func update_input_text():
	input_text.clear()
	input_text.push_font(font)
	input_text.push_font_size(64)
	
	if guess_code.size() >= code_length:
		input_text.append_text(array_as_string(guess_code))
	else:
		input_text.append_text(array_as_string(guess_code) + " _")

func input_number(next_number : int):
	guess_code.append(next_number)
	reset_length()
	update_input_text()
	check_answer()

func reset_length():
	if guess_code.size() > code_length:
		guess_code.clear()

func check_answer():
	if answer_code == guess_code:
		Singleton.minigame_controller.minigame_completed(1)

func array_as_string(array : Array[int]) -> String:
	var out_string : String
	for i in array.size():
		out_string = out_string + " " + str(array[i])
	return out_string

func _on_button_1_button_down() -> void:
	input_number(1)

func _on_button_2_button_down() -> void:
	input_number(2)

func _on_button_3_button_down() -> void:
	input_number(3)

func _on_button_4_button_down() -> void:
	input_number(4)

func _on_button_5_button_down() -> void:
	input_number(5)

func _on_button_6_button_down() -> void:
	input_number(6)

func _on_button_7_button_down() -> void:
	input_number(7)

func _on_button_8_button_down() -> void:
	input_number(8)

func _on_button_9_button_down() -> void:
	input_number(9)
