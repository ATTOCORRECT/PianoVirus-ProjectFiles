extends Node3D
var look_target
var currently_looking
const LOOK_SPEED = 10

var current_anchor

var up_anchor
var left_anchor
var down_anchor
var right_anchor

var up_look_dictionary
var left_look_dictionary
var down_look_dictionary
var right_look_dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	up_anchor = $"../Anchors/Up Anchor"
	left_anchor = $"../Anchors/Left Anchor"
	down_anchor = $"../Anchors/Down Anchor"
	right_anchor = $"../Anchors/Right Anchor"
	
	#up_look_dictionary = {up_anchor: null, left_anchor: null, down_anchor: up_anchor, right_anchor: null}
	#left_look_dictionary = {up_anchor: left_anchor, left_anchor: null, down_anchor: null, right_anchor: up_anchor}
	#down_look_dictionary = {up_anchor: down_anchor, left_anchor: null, down_anchor: null, right_anchor: null}
	#right_look_dictionary = {up_anchor: right_anchor, left_anchor: up_anchor, down_anchor: null, right_anchor: null}
	
	up_look_dictionary = {up_anchor: null, left_anchor: up_anchor, down_anchor: up_anchor, right_anchor: up_anchor}
	left_look_dictionary = {up_anchor: left_anchor, left_anchor: null, down_anchor: left_anchor, right_anchor: up_anchor}
	down_look_dictionary = {up_anchor: down_anchor, left_anchor: down_anchor, down_anchor: null, right_anchor: down_anchor}
	right_look_dictionary = {up_anchor: right_anchor, left_anchor: up_anchor, down_anchor: right_anchor, right_anchor: null}
	
	currently_looking = up_anchor.position
	set_look_target(up_anchor)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	currently_looking = lerp(currently_looking, look_target, delta * LOOK_SPEED)
	look_at(currently_looking)

func set_look_target(anchor):
	if anchor != null:
		current_anchor = anchor
		look_target = anchor.position

func _input(event):
	if event.is_action_pressed("look_up"):
		set_look_target(up_look_dictionary[current_anchor])
	
	if event.is_action_pressed("look_left"):
		set_look_target(left_look_dictionary[current_anchor])
	
	if event.is_action_pressed("look_down"):
		set_look_target(down_look_dictionary[current_anchor])
	
	if event.is_action_pressed("look_right"):
		set_look_target(right_look_dictionary[current_anchor])
