extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_1_button_down() -> void:
	print("1")
	pass # Replace with function body.


func _on_button_2_button_down() -> void:
	print("2")
	Singleton.minigame_controller.minigame_completed(1)
	pass # Replace with function body.
