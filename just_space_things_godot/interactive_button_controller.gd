extends Node3D

var toggle = false

@onready var panelMovingSound = $ScreenMoving

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
		panelMovingSound.play()
		$AnimationPlayer.play("Button_push")
		if toggle:
			toggle = false
			$"../Map/AnimationPlayer".play_backwards("Flip_Map")
		else:
			toggle = true
			$"../Map/AnimationPlayer".play("Flip_Map")
