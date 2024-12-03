extends Node3D

var toggle = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is not InputEventMouseButton:
		return
	
	if event.pressed == true:
		if toggle:
			toggle = false
			$"../Panel 1/AnimationPlayer".play_backwards("new_animation")
		else:
			toggle = true
			$"../Panel 1/AnimationPlayer".play("new_animation")
