extends Node3D
var look_target
var currently_looking
const LOOK_SPEED = 10

var up_anchor
var left_anchor
var down_anchor
var right_anchor

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	up_anchor = $"../Anchors/Up Anchor"
	left_anchor = $"../Anchors/Left Anchor"
	down_anchor = $"../Anchors/Down Anchor"
	right_anchor = $"../Anchors/Right Anchor"
	
	currently_looking = up_anchor.position
	set_look_target(currently_looking)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	currently_looking = lerp(currently_looking, look_target, delta * LOOK_SPEED)
	look_at(currently_looking)

func set_look_target(new_target: Vector3):
	look_target = new_target

func _input(event):
	if event.is_action_pressed("look_up"):
		set_look_target(up_anchor.position)
	
	if event.is_action_pressed("look_left"):
		set_look_target(left_anchor.position)
	
	if event.is_action_pressed("look_down"):
		set_look_target(down_anchor.position)
	
	if event.is_action_pressed("look_right"):
		set_look_target(right_anchor.position)
