extends Control

var correct_code
var user_code

var code_label
var userCode_label

# Called when the node enters the scene tree for the first time.
func _ready():
	correct_code[0] = randf_range(0, 9)
	correct_code[1] = randf_range(0, 9)
	correct_code[2] = randf_range(0, 9)
	correct_code[3] = randf_range(0, 9)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
