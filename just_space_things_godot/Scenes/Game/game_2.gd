extends Node3D

@export var menu_panel : Node3D
@export var menu_panel_animator : AnimationPlayer

@export var pause_menu : Control
@export var main_menu : Control

var animating = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu_panel_animator.current_animation = "menu_panel_animation"
	menu_panel_animator.stop()
	get_tree().paused = true
	pause_menu.visible = false
	main_menu.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") && get_tree().paused == false:
		play_to_pause()
		



func play_to_pause():
	if animating:
		return
	
	animating = true
	show_menu_panel()
	pause_menu.visible = true
	await get_tree().create_timer(1).timeout
	get_tree().paused = true
	animating = false

func pause_to_play():
	if animating:
		return
	
	animating = true
	hide_menu_panel()
	get_tree().paused = false
	await get_tree().create_timer(1).timeout
	pause_menu.visible = false
	animating = false

func pause_to_menu():
	pause_menu.visible = false
	main_menu.visible = true

func menu_to_play():
	if animating:
		return
	
	animating = true
	hide_menu_panel()
	get_tree().paused = false
	await get_tree().create_timer(1).timeout
	main_menu.visible = false
	animating = false



func hide_menu_panel():
	menu_panel_animator.play()

func show_menu_panel():
	menu_panel_animator.play_backwards()



func _on_menu_play_pressed() -> void:
	menu_to_play()

func _on_menu_quit_pressed() -> void:
	get_tree().quit()

func _on_pause_resume_pressed() -> void:
	pause_to_play()

func _on_pause_exit_pressed() -> void:
	pause_to_menu()
