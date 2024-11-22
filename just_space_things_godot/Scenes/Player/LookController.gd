extends Node3D
var look_target
var currently_looking
const LOOK_SPEED = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currently_looking = $"../Anchors/Up Anchor".position
	set_look_target(currently_looking)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	currently_looking = lerp(currently_looking, look_target, delta * LOOK_SPEED)
	look_at(currently_looking)

func set_look_target(new_target: Vector3):
	look_target = new_target

func _input(event):
	if event.is_action_pressed("look_up"):
		set_look_target($"../Anchors/Up Anchor".position)
	
	if event.is_action_pressed("look_left"):
		set_look_target($"../Anchors/Left Anchor".position)
	
	if event.is_action_pressed("look_down"):
		set_look_target($"../Anchors/Down Anchor".position)
	
	if event.is_action_pressed("look_right"):
		set_look_target($"../Anchors/Right Anchor".position)
